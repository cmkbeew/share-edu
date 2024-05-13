package com.fullstack4.shareedu.mapper;

import com.fullstack4.shareedu.domain.MemberVO;

public interface LoginMapper {
    MemberVO login(String user_id);

    void failCountUp(String user_id);

    void updateLoginInfo(String user_id);
}
