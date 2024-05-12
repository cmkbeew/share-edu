package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.dto.MemberDTO;

public interface MemberService {
    int findById(String user_id);

    int findByEmail(String email);

    int join(MemberDTO memberDTO);

    int modify(MemberDTO memberDTO);

    int delete(String user_id);
}
