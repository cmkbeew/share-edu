package com.fullstack4.shareedu.controller;

import com.fullstack4.shareedu.dto.*;
import com.fullstack4.shareedu.service.MyclassService;
import com.fullstack4.shareedu.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Arrays;
import java.util.List;

@Log4j2
@Controller
@RequiredArgsConstructor
@RequestMapping("/myclass")
public class MyClassController {

    private final MyclassService myclassService;

    @GetMapping("/home")
    public void home(int member_idx, Model model, HttpServletRequest req) {
        MyclassDTO myclassDTO = myclassService.selectOne(member_idx);

        if(myclassDTO != null) {
            List<String> shareList = myclassService.selectSharedId(myclassDTO.getEdu_idx());

            model.addAttribute("myclassDTO", myclassDTO);
            model.addAttribute("shareList", shareList);
        }
        List<HomeShareDTO> receiveClass = myclassService.receiveClass(req.getSession().getAttribute("user_id").toString());

        model.addAttribute("receiveClass", receiveClass);
    }

    @GetMapping("/regist")
    public void regist() {

    }

    @GetMapping("/sharing")
    public void sharing(int member_idx, Model model) {
        List<MemberDTO> memberList = myclassService.selectAllMember(member_idx);

        model.addAttribute("memberList", memberList);
    }

    @ResponseBody
    @PostMapping("/searchMember")
    public List<MemberDTO> searchMember(String search_word, HttpServletRequest req) {
        HttpSession session = req.getSession();
        String user_id = session.getAttribute("user_id").toString();

        List<MemberDTO> dtoList = myclassService.searchMember(search_word, user_id);

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
        };

        String save_file_name = "";

        if(!multipartFile.isEmpty()) {
            save_file_name = FileUploadUtil.saveFile(multipartFile, "myclass");
            myclassDTO.setOrg_file_name(multipartFile.getOriginalFilename());
            myclassDTO.setSave_file_name(save_file_name);
        } else {
            myclassDTO.setOrg_file_name("default.png");
            myclassDTO.setSave_file_name("default.png");
        }

        int result = myclassService.regist(myclassDTO);

        if(result > 0) {
            return "redirect:/myclass/home?member_idx=" + myclassDTO.getMember_idx();
        } else {
            redirectAttributes.addAttribute("myclassDTO", myclassDTO);

            return "redirect:/myclass/regist";
        }
    }

    @GetMapping("/myclass")
    public void myclass(int member_idx, PageRequestDTO pageRequestDTO, Model model) {
        pageRequestDTO.setMember_idx(member_idx);

        PageResponseDTO<MyclassDTO> responseDTO = myclassService.myclass(pageRequestDTO);

        model.addAttribute("responseDTO", responseDTO);
    }

    @GetMapping("/view")
    public void view(int edu_idx, Model model) {
        MyclassDTO myclassDTO = myclassService.view(edu_idx);

        List<String> sharedIdList = myclassService.selectSharedId(edu_idx);

        model.addAttribute("myclassDTO", myclassDTO);
        model.addAttribute("sharedIdList", sharedIdList);
    }

    @GetMapping("/modify")
    public void modify(int edu_idx, Model model) {
        MyclassDTO myclassDTO = myclassService.view(edu_idx);

        List<String> sharedIdList = myclassService.selectSharedId(edu_idx);

        model.addAttribute("myclassDTO", myclassDTO);
        model.addAttribute("sharedIdList", sharedIdList);
    }

    @PostMapping("/modify")
    public String modify(@RequestParam("file") MultipartFile multipartFile,
                         @Valid MyclassDTO myclassDTO,
                         BindingResult bindingResult,
                         RedirectAttributes redirectAttributes) {
        if(bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
            redirectAttributes.addFlashAttribute("myclassDTO", myclassDTO);

            return "redirect:/myclass/modify?edu_idx="+myclassDTO.getEdu_idx();
        };

        String save_file_name = "";

        if(!multipartFile.isEmpty()) {
            if(!myclassDTO.getSave_file_name().equals("default.png")) {
                FileUploadUtil.deleteFile(myclassDTO.getSave_file_name(), "myclass");
            }

            save_file_name = FileUploadUtil.saveFile(multipartFile, "myclass");

            myclassDTO.setOrg_file_name(multipartFile.getOriginalFilename());
            myclassDTO.setSave_file_name(save_file_name);
        } else {
            // 파일이 없어도 기존 파일 유지
            myclassDTO.setOrg_file_name(myclassDTO.getOrg_file_name());
            myclassDTO.setSave_file_name(myclassDTO.getSave_file_name());
        }

        int result = myclassService.modify(myclassDTO);

        if(result > 0) {
            return "redirect:/myclass/view?edu_idx=" + myclassDTO.getEdu_idx();
        } else {
            redirectAttributes.addAttribute("myclassDTO", myclassDTO);

            return "redirect:/myclass/modify?edu_id=" + myclassDTO.getEdu_idx();
        }
    }

    @ResponseBody
    @PostMapping("/delete")
    public String delete(int edu_idx) {
        MyclassDTO myclassDTO = myclassService.view(edu_idx);

        int result = myclassService.delete(edu_idx);

        FileUploadUtil.deleteFile(myclassDTO.getSave_file_name(), "myclass");

        if(result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    @GetMapping("/shareList")
    public void shareList(int member_idx, PageRequestDTO pageRequestDTO, HttpServletRequest req, Model model) {
        pageRequestDTO.setMember_idx(member_idx);

        String user_id = req.getSession().getAttribute("user_id").toString();
        pageRequestDTO.setUser_id(user_id);

        PageResponseDTO<ShareDTO> responseDTO = myclassService.shareList(pageRequestDTO);

        log.info("responseDTO : {}", responseDTO);

        model.addAttribute("responseDTO", responseDTO);
    }

    @GetMapping("/receiveList")
    public void receiveList(int member_idx, PageRequestDTO pageRequestDTO, HttpServletRequest req, Model model) {
        pageRequestDTO.setMember_idx(member_idx);

        String user_id = req.getSession().getAttribute("user_id").toString();
        pageRequestDTO.setUser_id(user_id);

        PageResponseDTO<ShareDTO> responseDTO = myclassService.receiveList(pageRequestDTO);

        log.info("responseDTO : {}", responseDTO);

        model.addAttribute("responseDTO", responseDTO);
    }
}
