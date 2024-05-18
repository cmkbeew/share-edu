package com.fullstack4.shareedu.mapper;

import com.fullstack4.shareedu.domain.MemberVO;
import com.fullstack4.shareedu.domain.MyclassVO;
import com.fullstack4.shareedu.dto.HomeShareDTO;
import com.fullstack4.shareedu.dto.MyclassDTO;
import com.fullstack4.shareedu.dto.PageRequestDTO;
import com.fullstack4.shareedu.dto.ShareDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MyclassMapper {

    List<MyclassVO> myclass(PageRequestDTO pageRequestDTO);

    int myclassCount(PageRequestDTO pageRequestDTO);

    int regist(MyclassVO myclassVO);

    List<MemberVO> selectAllMember(int member_idx);

    List<MemberVO> searchMember(@Param(value = "search_word") String search_word, @Param(value = "user_id") String user_id);

    int findClassIdx();

    int shareClass(@Param(value = "edu_idx") int edu_idx, @Param(value = "share_user_id") String share_user_id, @Param(value = "shared_id") String shared_id);

    MyclassVO selectOne(int member_idx);

    List<String> selectSharedId(int edu_idx);

    List<HomeShareDTO> receiveClass(String user_id);

    MyclassVO view(int edu_idx);

    int modify(MyclassVO myclassVO);

    void deleteSharedId(int edu_idx);

    int delete(int edu_idx);

    List<ShareDTO> shareList(PageRequestDTO pageRequestDTO);

    int shareCount(PageRequestDTO pageRequestDTO);

    String[] findSharedId(@Param(value = "edu_idx") int edu_idx, @Param(value = "user_id") String user_id);

    List<ShareDTO> receiveList(PageRequestDTO pageRequestDTO);

    int receiveCount(PageRequestDTO pageRequestDTO);
}
