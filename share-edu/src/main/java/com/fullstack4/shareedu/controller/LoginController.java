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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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

    @PostMapping("/login")
    public String loginPOST(@Valid LoginDTO loginDTO,
                            BindingResult bindingResult,
                            RedirectAttributes redirectAttributes,
                            HttpServletRequest req,
                            HttpServletResponse res) {
        if(bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
            redirectAttributes.addFlashAttribute("loginDTO", loginDTO);

            return "redirect:/login/login";
        }

        MemberDTO memberDTO = loginService.login(loginDTO.getUser_id(), loginDTO.getPwd());

        if(memberDTO != null) {
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

            return "redirect:/";
        } else {
            redirectAttributes.addFlashAttribute("login_err_msg", "사용자 정보가 일치하지 않습니다.");
            redirectAttributes.addFlashAttribute("loginDTO", loginDTO);

            return "redirect:/login/login";
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
