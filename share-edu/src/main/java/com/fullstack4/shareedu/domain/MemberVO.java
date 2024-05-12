package com.fullstack4.shareedu.domain;

import lombok.*;

import java.time.LocalDate;

@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
    private String user_id;
    private String pwd;
    private String name;
    private String email;
    private String phone;
    private LocalDate reg_date;
}
