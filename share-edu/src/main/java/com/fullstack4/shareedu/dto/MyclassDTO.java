package com.fullstack4.shareedu.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MyclassDTO {

    private int edu_idx;
    @NotBlank(message = "제목을 입력하세요.")
    private String title;
    @NotBlank(message = "내용을 입력하세요.")
    private String content;
    private String org_file_name;
    private String save_file_name;

    @NotBlank(message = "노출여부를 선택하세요.")
    private String display_state;
    private String display_start;
    private String display_end;
    private String category;
    private String tag;
    private String like_cnt;
    private LocalDate reg_date;
    private LocalDate modify_date;

    private String share_id;
    private int member_idx;
    private String name;
}
