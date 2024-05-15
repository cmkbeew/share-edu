package com.fullstack4.shareedu.mapper;

import com.fullstack4.shareedu.domain.MemberVO;
import com.fullstack4.shareedu.domain.MyclassVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MyclassMapper {

    int regist(MyclassVO myclassVO);

    List<MemberVO> searchMember(@Param(value = "search_word") String search_word, @Param(value = "user_id") String user_id);
}
