package com.fullstack4.shareedu.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MyclassVO {

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
    private String like_cnt;
    private LocalDate reg_date;
    private LocalDate modify_date;

    private String share_id;
    private int member_idx;
}
