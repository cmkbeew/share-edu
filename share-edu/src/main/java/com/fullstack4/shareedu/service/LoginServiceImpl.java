package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.domain.MemberVO;
import com.fullstack4.shareedu.dto.MemberDTO;
import com.fullstack4.shareedu.mapper.LoginMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

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
        log.info("vo : {}", vo);

        if(vo != null && vo.getPwd().equals(pwd)) {
            dto = modelMapper.map(vo, MemberDTO.class);
        } else {
            loginMapper.failCountUp(user_id);
        }

        return dto;
    }

    @Override
    public void updateLoginInfo(String user_id) {
        loginMapper.updateLoginInfo(user_id);
    }
}