package com.fullstack4.shareedu.controller;

import com.fullstack4.shareedu.dto.MemberDTO;
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

    @GetMapping("/view")
    public void view(@RequestParam(name="user_id", defaultValue = "") String user_id,
                     Model model) {
    }

    @GetMapping("/modify")
    public void modifyGET(@RequestParam(name="user_id", defaultValue = "") String user_id,
                          Model model) {
    }

    @PostMapping("/modify")
    public String modifyPOST() {
            return null;

    }

    @PostMapping("/delete")
    public String deletePOST(String user_id) {

        return null;
    }
}
