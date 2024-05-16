package com.fullstack4.shareedu.service;

import com.fullstack4.shareedu.domain.MemberVO;
import com.fullstack4.shareedu.domain.MyclassVO;
import com.fullstack4.shareedu.dto.*;
import com.fullstack4.shareedu.mapper.MyclassMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Log4j2
@Service
@RequiredArgsConstructor
public class MyclassServiceImpl implements MyclassService {
    private final MyclassMapper myclassMapper;
    private final ModelMapper modelMapper;

    @Override
    public PageResponseDTO<MyclassDTO> myclass(PageRequestDTO pageRequestDTO) {
        List<MyclassVO> voList = myclassMapper.myclass(pageRequestDTO);

        List<MyclassDTO> dtoList = voList.stream()
                .map(vo -> modelMapper.map(vo, MyclassDTO.class))
                .collect(Collectors.toList());

        for(MyclassDTO dto : dtoList) {
            if(dto.getTitle().length() > 30) {
                dto.setTitle(dto.getTitle().substring(0, 30) + "...");
            }
        }

        int total_count = myclassMapper.myclassCount(pageRequestDTO);

        PageResponseDTO<MyclassDTO> responseDTO = PageResponseDTO.<MyclassDTO>withAll()
                .requestDTO(pageRequestDTO)
                .dtoList(dtoList)
                .total_count(total_count)
                .build();

        return responseDTO;
    }

    @Override
    public int myclassCount(PageRequestDTO pageRequestDTO) {
        return myclassMapper.myclassCount(pageRequestDTO);
    }

    @Override
    public int regist(MyclassDTO myclassDTO) {
        MyclassVO vo = modelMapper.map(myclassDTO, MyclassVO.class);

        // 학습 등록
        int result = myclassMapper.regist(vo);

        // 등록한 학습 idx 찾아오기
        int edu_idx = myclassMapper.findClassIdx();

        // 공유 테이블 데이터 넣기
        String[] ids = myclassDTO.getShared_id();
        for(String shared_id : ids) {
            myclassMapper.shareClass(edu_idx, myclassDTO.getUser_id(), shared_id);
        }

        return result;
    }

    @Override
    public List<MemberDTO> selectAllMember(int member_idx) {
        List<MemberVO> voList = myclassMapper.selectAllMember(member_idx);

        List<MemberDTO> dtoList = voList.stream()
                .map(vo -> modelMapper.map(vo, MemberDTO.class))
                .collect(Collectors.toList());

        return dtoList;
    }

    @Override
    public List<MemberDTO> searchMember(String search_word, String user_id) {
        List<MemberVO> voList = myclassMapper.searchMember(search_word, user_id);

        List<MemberDTO> dtoList = voList.stream()
                .map(vo -> modelMapper.map(vo, MemberDTO.class))
                .collect(Collectors.toList());

        return dtoList;
    }

    @Override
    public MyclassDTO selectOne(int member_idx) {
        MyclassVO vo = myclassMapper.selectOne(member_idx);
        MyclassDTO dto = null;

        if(vo != null) {
            dto = modelMapper.map(vo, MyclassDTO.class);
        }
        if(dto != null) {
            if(dto.getTitle().length() > 15) {
                dto.setTitle(dto.getTitle().substring(0, 15) + "...");
            }

            if(dto.getContent().length() > 15) {
                dto.setContent(dto.getContent().substring(0, 15) + "...");
            }
        }

        return dto;
    }

    @Override
    public List<String> selectSharedId(int edu_idx) {
        List<String> shareList = myclassMapper.selectSharedId(edu_idx);

        return shareList;
    }

    @Override
    public List<HomeShareDTO> receiveClass(String user_id) {
        List<HomeShareDTO> receiveList = myclassMapper.receiveClass(user_id);

        return receiveList;
    }

    @Override
    public MyclassDTO view(int edu_idx) {
        MyclassVO vo = myclassMapper.view(edu_idx);

        MyclassDTO dto = modelMapper.map(vo, MyclassDTO.class);

        return dto;
    }

    @Override
    @Transactional
    public int modify(MyclassDTO myclassDTO) {
        MyclassVO vo = modelMapper.map(myclassDTO, MyclassVO.class);

        int result = myclassMapper.modify(vo);

        myclassMapper.deleteSharedId(myclassDTO.getEdu_idx());

        String[] shared_ids = myclassDTO.getShared_id();

        for(String shared_id : shared_ids) {
            myclassMapper.shareClass(myclassDTO.getEdu_idx(), myclassDTO.getUser_id(), shared_id);
        }

        return result;
    }

    @Override
    public int delete(int edu_idx) {
        int result = myclassMapper.delete(edu_idx);

        return result;
    }

    @Override
    public PageResponseDTO<ShareDTO> shareList(PageRequestDTO pageRequestDTO) {
        List<ShareDTO> shareList = myclassMapper.shareList(pageRequestDTO);

        for(ShareDTO dto : shareList) {
            if(dto.getTitle().length() > 30) {
                dto.setTitle(dto.getTitle().substring(0, 30) + "...");
            }
        }

        int total_count = myclassMapper.shareCount(pageRequestDTO);

        PageResponseDTO<ShareDTO> responseDTO = PageResponseDTO.<ShareDTO>withAll()
                .requestDTO(pageRequestDTO)
                .dtoList(shareList)
                .total_count(total_count)
                .build();

        return responseDTO;
    }
}
