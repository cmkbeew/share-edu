package com.fullstack4.shareedu.domain;

import lombok.*;

import java.time.LocalDate;

@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
    private int member_idx;
    private String user_id;
    private String pwd;
    private String name;
    private String email;
    private String phone;
    private LocalDate reg_date;
    private int fail_cnt;
    private LocalDate last_login_date;
    private String member_state;
    private String temp_pwd;
}
