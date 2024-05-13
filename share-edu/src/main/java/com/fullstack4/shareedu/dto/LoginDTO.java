package com.fullstack4.shareedu.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginDTO {

    @NotBlank(message = "아이디를 입력하세요.")
    private String user_id;

    @NotBlank(message = "비밀번호를 입력하세요.")
    private String pwd;

    private String save_id;
    private String auto_login;

    private int fail_cnt;
    private LocalDate last_login_date;
    private String member_state;
}
