package com.fullstack4.shareedu.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MypageDTO {

    private String user_id;
    private String name;

//    @Pattern(regexp="^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$", message = "영문 + 숫자 + 특수문자 조합으로 최소 8자리 이상만 허용됩니다.")
    private String pwd;

    private String pwd2;

    private String phone;

    @NotBlank(message = "휴대폰 번호를 입력하세요.")
    private String phone1;

    @NotBlank(message = "휴대폰 가운데 번호를 입력하세요.")
    @Pattern(regexp = "^[1-9]{1}[0-9]{3}$", message = "휴대폰 가운데 번호 형식에 맞춰 입력하세요.")
    private String phone2;

    @NotBlank(message = "휴대폰 끝 번호를 입력하세요.")
    @Pattern(regexp = "^[0-9]{4}$", message = "휴대폰 끝 번호 형식에 맞춰 입력하세요.")
    private String phone3;

    @NotBlank(message = "이메일을 입력하세요.")
    @Pattern(regexp = "[a-z0-9]+@[a-z]+\\.[a-z]{2,3}", message = "이메일 형식에 맞춰 입력하세요.")
    private String email;

    public String getPhone() {
        return phone1+phone2+phone3;
    }

    public String getPhone1() {
        String phone1 = this.phone.substring(0, 3);
        return phone1;
    }
    public String getPhone2() {
        String phone2 = this.phone.substring(3, 7);
        return phone2;
    }
    public String getPhone3() {
        String phone3 = this.phone.substring(7);
        return phone3;
    }
}
