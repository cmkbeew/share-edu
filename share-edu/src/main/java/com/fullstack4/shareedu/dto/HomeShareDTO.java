package com.fullstack4.shareedu.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class HomeShareDTO {
    private String org_file_name;
    private String save_file_name;
    private String share_user_id;
    private int like_cnt;
}
