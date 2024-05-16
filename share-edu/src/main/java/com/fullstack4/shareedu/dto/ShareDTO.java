package com.fullstack4.shareedu.dto;

import lombok.*;

import javax.validation.constraints.NotBlank;
import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ShareDTO {
    private int edu_idx;
    private String title;
    private String content;
    private String org_file_name;
    private String save_file_name;
    private String display_state;
    private String display_start;
    private String display_end;
    private String category;
    private String tag;
    private int like_cnt;
    private LocalDate reg_date;
    private LocalDate modify_date;

    private int share_idx;
    private String share_user_id;
    private String shared_id;

    private String user_id;
}
