package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.domain.MemberVO;
import com.fullstack4.shareedu.dto.MemberDTO;
import com.fullstack4.shareedu.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Log4j2
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final ModelMapper modelMapper;
    private final MemberMapper memberMapper;

    @Override
    public int findById(String user_id) {
        int result = memberMapper.findById(user_id);

        return result;
    }

    @Override
    public int findByEmail(String email) {
        int result = memberMapper.findByEmail(email);

        return result;
    }

    @Override
    public int join(MemberDTO memberDTO) {
        MemberVO vo = modelMapper.map(memberDTO, MemberVO.class);

        int result = memberMapper.join(vo);

        return result;
    }

    @Override
    public int modify(MemberDTO memberDTO) {
        return 0;
    }

    @Override
    public int delete(String user_id) {
        return 0;
    }
}
