package com.fullstack4.shareedu.controller;

import com.fullstack4.shareedu.dto.LoginDTO;
import com.fullstack4.shareedu.dto.MemberDTO;
import com.fullstack4.shareedu.service.LoginService;
import com.fullstack4.shareedu.util.CookieUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Log4j2
@Controller
@RequiredArgsConstructor
@RequestMapping("/login")
public class LoginController {

    private final LoginService loginService;

    @GetMapping("/login")
    public void loginGET(HttpServletRequest req, Model model) {
        String save_id = CookieUtil.getCookieValue("save_id", req);
        String auto_login = CookieUtil.getCookieValue("auto_login", req);

        if(!save_id.equals("")) {
            model.addAttribute("save_id", save_id);
        }
        if(!auto_login.equals("")) {
            model.addAttribute("auto_login", auto_login);
        }
    }

    @ResponseBody
    @PostMapping("/login")
    public Map<String, String> loginPOST(@RequestBody LoginDTO loginDTO,
//                                         @RequestParam(name = "user_id") String user_id,
//                                         @RequestParam(name = "pwd") String pwd,
                                         HttpServletRequest req,
                                         HttpServletResponse res) throws IOException {
        Map<String, String> resultMap = new HashMap<>();

        log.info("loginDTO : {}", loginDTO);

        if(loginDTO.getUser_id() == null || loginDTO.getUser_id().equals("") || loginDTO.getUser_id().length() == 0) {
            resultMap.put("state", "emptyId");
            resultMap.put("msg", "아이디를 입력하세요.");

            return resultMap;
        }
        if(loginDTO.getPwd() == null || loginDTO.getPwd().equals("") || loginDTO.getPwd().length() == 0) {
            resultMap.put("state", "emptyPwd");
            resultMap.put("msg", "비밀번호를 입력하세요.");

            return resultMap;
        }

        MemberDTO memberDTO = loginService.login(loginDTO.getUser_id(), loginDTO.getPwd());

        if(memberDTO != null) {
            // 5회 이상 로그인 실패
            if(memberDTO.getFail_cnt() > 5) {
                resultMap.put("state", "lockedId");
                resultMap.put("msg", "5회 이상 로그인 실패로 잠금 처리된 아이디입니다.\n 관리자에게 문의해 주세요.");

                return resultMap;
            }

            // 마지막 로그인 날짜 확인
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.MONTH, -6);
            Date date = calendar.getTime();

            LocalDate localDate = new java.sql.Date(date.getTime()).toLocalDate();

            if(memberDTO.getLast_login_date().isBefore(localDate)) {
                resultMap.put("state", "longTime");
                resultMap.put("msg", "6개월 이상 로그인 이력이 없습니다.\n관리자에게 문의해 주세요.");

                return resultMap;
            }

            // member_state가 N일 때
            if(memberDTO.getMember_state().equals("N")) {
                resultMap.put("state", "blockedId");
                resultMap.put("msg", "관리자 또는 이용 규칙 위반에 의해 이용이 제한된 아이디입니다.\n관리자에게 문의해 주세요.");

                return resultMap;
            }

            // 세션에 로그인 유저 정보 넣기
            HttpSession session = req.getSession();
            session.setAttribute("user_id", memberDTO.getUser_id());
            session.setAttribute("name", memberDTO.getName());
            session.setAttribute("email", memberDTO.getEmail());
            session.setAttribute("phone", memberDTO.getPhone());

            // 아이디 저장 -> 쿠키에 아이디 저장
            if(loginDTO.getSave_id() != null) {
                CookieUtil.setCookies("save_id", memberDTO.getUser_id(), 60*60*24*7, res);
            } else {
                CookieUtil.deleteCookie("save_id", "", 0, res);
            }

            // 자동 로그인 확인
            if(loginDTO.getAuto_login() != null) {
                CookieUtil.setCookies("auto_login", memberDTO.getUser_id(), 60*60*24*7, res);
                CookieUtil.setCookies("user_name", memberDTO.getName(), 60*60*24*7, res);
            }

            // TODO: fail_cnt, last_login_date 수정
            loginService.updateLoginInfo(memberDTO.getUser_id());

            resultMap.put("state", "success");
            resultMap.put("msg", "로그인 성공");

            return resultMap;
        } else {
            resultMap.put("state", "noUser");
            resultMap.put("msg", "입력하신 아이디 또는 패스워드가 일치하지 않습니다.");

            return resultMap;
        }
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest req, HttpServletResponse res) {
        HttpSession session = req.getSession(false);

        if (session != null) {
            session.invalidate();
        }
        CookieUtil.deleteCookie("auto_login", "", 0, res);
        CookieUtil.deleteCookie("user_name", "", 0, res);

        return "redirect:/";
    }
}
