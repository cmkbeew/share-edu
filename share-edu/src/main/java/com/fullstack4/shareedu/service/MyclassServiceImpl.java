package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.domain.MemberVO;
import com.fullstack4.shareedu.domain.MyclassVO;
import com.fullstack4.shareedu.dto.MemberDTO;
import com.fullstack4.shareedu.dto.MyclassDTO;
import com.fullstack4.shareedu.mapper.MyclassMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Log4j2
@Service
@RequiredArgsConstructor
public class MyclassServiceImpl implements MyclassService {
    private final MyclassMapper myclassMapper;
    private final ModelMapper modelMapper;

    @Override
    public int regist(MyclassDTO myclassDTO) {
        MyclassVO vo = modelMapper.map(myclassDTO, MyclassVO.class);

        int result = myclassMapper.regist(vo);

        return result;
    }

    @Override
    public List<MemberDTO> searchMember(String search_word, String user_id) {
        List<MemberVO> voList = myclassMapper.searchMember(search_word, user_id);

        log.info("voList : {}", voList);

        List<MemberDTO> dtoList = voList.stream()
                .map(vo -> modelMapper.map(vo, MemberDTO.class))
                .collect(Collectors.toList());

        log.info("dtoList : {}", dtoList);

        return dtoList;
    }
}
