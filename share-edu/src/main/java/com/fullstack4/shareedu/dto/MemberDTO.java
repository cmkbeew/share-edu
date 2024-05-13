package com.fullstack4.shareedu.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {

    @NotBlank(message = "아이디를 입력하세요.")
    @Pattern(regexp = "^[a-z0-9]{4,12}", message = "4~12자 이내의 영어 소문자 및 숫자만 입력이 가능합니다.")
    private String user_id;

    //'숫자', '문자', '특수문자' 무조건 1개 이상, 비밀번호 '최소 8자에서 최대 16자'까지 허용
    //(특수문자는 정의된 특수문자만 사용 가능)
    @NotBlank(message = "비밀번호를 입력하세요.")
    @Pattern(regexp="^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$", message = "영문 + 숫자 + 특수문자 조합으로 최소 8자리 이상만 허용됩니다.")
    private String pwd;

    @NotBlank(message = "이름을 입력하세요.")
    @Pattern(regexp = "[가-힣a-zA-Z]{2,20}", message = "2~20자의 한글, 영어만 입력 가능합니다.")
    private String name;

    @NotBlank(message = "이메일을 입력하세요.")
    @Pattern(regexp = "[a-z0-9]+@[a-z]+\\.[a-z]{2,3}", message = "이메일 형식에 맞춰 입력하세요.")
    private String email;

    @NotBlank(message = "휴대폰 번호를 입력하세요.")
    @Pattern(regexp = "^(010)[1-9]{1}[0-9]{3}[0-9]{4}$", message = "휴대폰 번호 형식에 맞춰 입력하세요.")
    private String phone;
    private LocalDate reg_date;

    private int fail_cnt;
    private LocalDate last_login_date;
    private String member_state;
}
