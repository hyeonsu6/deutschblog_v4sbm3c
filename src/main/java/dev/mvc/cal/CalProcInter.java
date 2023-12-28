package dev.mvc.cal;

import java.util.ArrayList;

public interface CalProcInter {

	// 일정 목록 조회
	public ArrayList<CalVO> callist(String id, String yyyyMM);

	// 상세 정보 조회
	public CalVO detail(int seq);

	// 글쓰기
	public int write(CalVO calVO);

	// 글삭제
	public int delete(int seq);

	// 글수정
	public int update(CalVO calVO);

	// 하루 일정 조회
	public ArrayList<CalVO> daylist(String id, String yyyyMMdd);
}
