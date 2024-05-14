package com.fullstack4.shareedu.mapper;

import com.fullstack4.shareedu.domain.MemberVO;
import org.apache.ibatis.annotations.Param;

public interface LoginMapper {
    MemberVO login(String user_id);

    void failCountUp(String user_id);

    void updateLoginInfo(String user_id);

    void changeTempPwd(@Param(value = "user_id") String user_id, @Param(value = "pwd") String pwd);

    int findPwdCheck(String user_id);

    String pwdCheck(String user_id);

    int changePwd(@Param(value = "user_id") String user_id, @Param(value = "pwd") String pwd);
}
