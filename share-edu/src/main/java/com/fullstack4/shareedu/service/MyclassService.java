package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.domain.MemberVO;
import com.fullstack4.shareedu.domain.MyclassVO;
import com.fullstack4.shareedu.dto.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MyclassService {
    PageResponseDTO<MyclassDTO> myclass(PageRequestDTO pageRequestDTO);

    int myclassCount(PageRequestDTO pageRequestDTO);

    int regist(MyclassDTO myclassDTO);

    List<MemberDTO> selectAllMember(int member_idx);

    List<MemberDTO> searchMember(String search_word, String user_id);

    MyclassDTO selectOne(int member_idx);

    List<String> selectSharedId(int edu_idx);

    List<HomeShareDTO> receiveClass(String user_id);

    MyclassDTO view(int edu_idx);

    int modify(MyclassDTO myclassDTO);

    int delete(int edu_idx);

    PageResponseDTO<ShareDTO> shareList(PageRequestDTO pageRequestDTO);

    String[] findSharedId(int edu_idx, String user_id);

    PageResponseDTO<ShareDTO> receiveList(PageRequestDTO pageRequestDTO);}
