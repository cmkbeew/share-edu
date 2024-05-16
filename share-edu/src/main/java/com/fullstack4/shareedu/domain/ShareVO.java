package com.fullstack4.shareedu.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ShareVO {

    private int share_idx;
    private int edu_idx;
    private String share_user_id;
    private String shared_id;
}
