package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.domain.MemberVO;
import com.fullstack4.shareedu.dto.MemberDTO;
import com.fullstack4.shareedu.mapper.LoginMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Log4j2
@Service
@RequiredArgsConstructor
public class LoginServiceImpl implements LoginService{

    private final LoginMapper loginMapper;
    private final ModelMapper modelMapper;

    @Override
    public MemberDTO login(String user_id, String pwd) {
        MemberVO vo = loginMapper.login(user_id);
        MemberDTO dto = null;

        if(vo != null && vo.getPwd().equals(pwd)) {
            dto = modelMapper.map(vo, MemberDTO.class);
        } else {
            // 아이디 일치, 비밀번호 불일치 시 fail_cnt+1
            loginMapper.failCountUp(user_id);
        }

        return dto;
    }

    @Override
    public void updateLoginInfo(String user_id) {
        loginMapper.updateLoginInfo(user_id);
    }

    @Override
    public String changeTempPwd(String user_id) {
        // 임시 비밀번호 생성
        UUID uuid = UUID.randomUUID();
        String[] uuids = uuid.toString().split("-");
        String tempPwd = uuids[0];

        log.info("tempPwd : {}", tempPwd);

        loginMapper.changeTempPwd(user_id, tempPwd);

        return tempPwd;
    }

    @Override
    public int findPwdCheck(String user_id) {
        int result = loginMapper.findPwdCheck(user_id);

        return result;
    }

    @Override
    public String pwdCheck(String user_id) {
        String old_pwd = loginMapper.pwdCheck(user_id);

        return old_pwd;
    }

    @Override
    public int changePwd(String user_id, String pwd) {
        int result = loginMapper.changePwd(user_id, pwd);

        return result;
    }
}