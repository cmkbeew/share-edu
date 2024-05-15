package com.fullstack4.shareedu.mapper;


import com.fullstack4.shareedu.domain.MemberVO;

public interface MemberMapper {
    int findById(String user_id);

    int findByEmail(String email);

    int join(MemberVO memberVO);

    MemberVO mypage(String user_id);

    int modify(MemberVO memberVO);

    int delete(String user_id);
}
