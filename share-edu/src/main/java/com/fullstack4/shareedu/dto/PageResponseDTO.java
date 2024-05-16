package com.fullstack4.shareedu.dto;

import lombok.Builder;
import lombok.Data;
import lombok.extern.log4j.Log4j2;

import java.time.LocalDate;
import java.util.List;

@Log4j2
@Data
public class PageResponseDTO<E> {

    private int total_count;
    private int page;
    private int page_size;
    private int page_skip_count;
    private int total_page;
    private int page_block_size;
    private int page_block_start;
    private int page_block_end;

    private boolean prev_page_flag;
    private boolean next_page_flag;

    List<E> dtoList;

    // 검색 조건
    private String[] search_type;
    private String search_word;
    private LocalDate search_date1;
    private LocalDate search_date2;

    private int member_idx;
    private String type;
    private String user_id;

    private String linkParams;

    PageResponseDTO() {}

    @Builder(builderMethodName = "withAll")
    public PageResponseDTO(PageRequestDTO requestDTO, List<E> dtoList, int total_count) {
        this.total_count = total_count;
        this.page = requestDTO.getPage();
        this.page_size = requestDTO.getPage_size();
        this.page_skip_count = requestDTO.getPage_skip_count();
        this.total_page = (int)Math.ceil(total_count / (double)page_size);
        this.page_block_size = requestDTO.getPage_block_size();
        this.page_block_start = (int)(Math.ceil(page / (double)page_block_size) -1 ) * page_block_size + 1;
        this.page_block_end = (int)Math.ceil(page / (double)page_block_size) * page_block_size;
        this.page_block_end = page_block_end > total_page ? total_page : page_block_end;
        this.prev_page_flag = (this.page_block_start > 1);
        this.next_page_flag = (this.total_page > this.page_block_end);

        this.member_idx = requestDTO.getMember_idx();
        this.type = requestDTO.getType();
        this.user_id = requestDTO.getUser_id();

        this.dtoList = dtoList;

        this.search_type = requestDTO.getSearch_type();

        StringBuilder sb = new StringBuilder();
        if(type != null) {
            sb.append("&type=" + type);
        }
        if(search_type != null) {
            for(String type : search_type) {
                sb.append("&search_type=" + type);
            }
        }

        this.search_word = requestDTO.getSearch_word();
        this.search_date1 = requestDTO.getSearch_date1();
        this.search_date2 = requestDTO.getSearch_date2();

        if(search_word != null) {
            sb.append("&search_word=" + search_word);
        }
        if(search_date1 != null) {
            sb.append("&search_date1=" + search_date1);
        }
        if(search_date2 != null) {
            sb.append("&search_date2=" + search_date2);
        }

        this.linkParams = "?member_idx=" + this.member_idx + "&page_size=" + this.page_size + sb;
    }

}
