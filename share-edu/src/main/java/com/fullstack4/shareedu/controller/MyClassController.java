package com.fullstack4.shareedu.controller;

import com.fullstack4.shareedu.dto.MemberDTO;
import com.fullstack4.shareedu.dto.MyclassDTO;
import com.fullstack4.shareedu.service.MyclassService;
import com.fullstack4.shareedu.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Log4j2
@Controller
@RequiredArgsConstructor
@RequestMapping("/myclass")
public class MyClassController {

    private final MyclassService myclassService;

    @GetMapping("/home")
    public void home() {

    }

    @GetMapping("/regist")
    public void regist() {

    }

    @GetMapping("/sharing")
    public void sharing() {
    }

    @ResponseBody
    @PostMapping("/searchMember")
    public List<MemberDTO> searchMember(String search_word, HttpServletRequest req) {
        log.info("search_word : {}", search_word);

        HttpSession session = req.getSession();
        String user_id = session.getAttribute("user_id").toString();

        List<MemberDTO> dtoList = myclassService.searchMember(search_word, user_id);

        log.info("dtoList : {}", dtoList);

        return dtoList;
    }

    @PostMapping("/regist")
    public String regist(@RequestParam("file") MultipartFile multipartFile,
                         @Valid MyclassDTO myclassDTO,
                         BindingResult bindingResult,
                         RedirectAttributes redirectAttributes) {
        if(bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
            redirectAttributes.addFlashAttribute("myclassDTO", myclassDTO);

            return "redirect:/myclass/regist";
        }

        log.info("myclassDTO : {}", myclassDTO);

        String save_file_name = "";

        if(!multipartFile.isEmpty()) {
            save_file_name = FileUploadUtil.saveFile(multipartFile, "myclass");
        }
        myclassDTO.setOrg_file_name(multipartFile.getOriginalFilename());
        myclassDTO.setSave_file_name(save_file_name);

        int result = myclassService.regist(myclassDTO);

        if(result > 0) {
            return "redirect:/myclass/home";
        } else {
            redirectAttributes.addAttribute("myclassDTO", myclassDTO);

            return "redirect:/myclass/regist";
        }
    }
}
