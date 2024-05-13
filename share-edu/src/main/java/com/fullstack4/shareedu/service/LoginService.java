package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.dto.MemberDTO;

public interface LoginService {
    MemberDTO login(String user_id, String pwd);

    void updateLoginInfo(String user_id);

}
