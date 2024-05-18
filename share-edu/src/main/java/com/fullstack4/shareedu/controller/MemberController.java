package com.fullstack4.shareedu.controller;

import com.fullstack4.shareedu.dto.MemberDTO;
import com.fullstack4.shareedu.dto.MypageDTO;
import com.fullstack4.shareedu.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Log4j2
@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;

    @ResponseBody
    @PostMapping("duplicateId")
    public String duplicateId(String user_id) {
        if(user_id != null) {
            int result = memberService.findById(user_id);

            if (result > 0) {
                return "idCheck";
            } else {
                return "pass";
            }
        }
        return "inputCheck";
    }

    @ResponseBody
    @PostMapping("duplicateEmail")
    public String duplicateEmail(String email) {
        if(email != null) {
            int result = memberService.findByEmail(email);

            if (result > 0) {
                return "emailCheck";
            } else {
                return "pass";
            }
        }
        return "inputCheck";
    }

    @GetMapping("/join")
    public void joinGET() {
    }

    @PostMapping("/join")
    public String joinPOST(@Valid MemberDTO memberDTO,
                           BindingResult bindingResult,
                           RedirectAttributes redirectAttributes) {
        if(bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
            redirectAttributes.addFlashAttribute("memberDTO", memberDTO);

            return "redirect:/member/join";
        }

        memberDTO.setPhone(memberDTO.getPhone1(), memberDTO.getPhone2(), memberDTO.getPhone3());

        if(memberDTO != null) {
            int result = memberService.join(memberDTO);

            if(result > 0) {
                return "redirect:/login/login";
            } else {
                return "/member/join";
            }
        } else {
            return "redirect:/member/join";
        }
    }

    @GetMapping("/mypage")
    public void mypage(String user_id, Model model) {
        MemberDTO memberDTO = memberService.mypage(user_id);
        memberDTO.setPhone1(memberDTO.getPhone().substring(0, 3));
        memberDTO.setPhone2(memberDTO.getPhone().substring(3, 7));
        memberDTO.setPhone3(memberDTO.getPhone().substring(7));

        model.addAttribute("memberDTO", memberDTO);
    }

    @PostMapping("/mypage")
    public String mypage(MemberDTO memberDTO) {

        log.info("memberDTO : {}", memberDTO);

        return null;
    }

    @PostMapping("/delete")
    public String deletePOST(String user_id) {

        return null;
    }
}
