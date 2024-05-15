package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.dto.MemberDTO;
import com.fullstack4.shareedu.dto.MyclassDTO;

import java.util.List;

public interface MyclassService {
    int regist(MyclassDTO myclassDTO);

    List<MemberDTO> searchMember(String search_word, String user_id);
}
