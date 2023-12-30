package dev.mvc.cal;

import java.util.ArrayList;

public interface CalProcInter {

	/**
	 * 등록, 추상 메소드 -> Spring Boot이 구현함.
	 * 
	 * @param calVO 객체
	 * @return 등록된 레코드 갯수
	 */
	public int create(CalVO calVO);

	/**
	 * 전체 목록
	 * 
	 * @return
	 */
	public ArrayList<CalVO> list_all();
	
	/**
	 * 전체 목록(달력형)
	 * 
	 * @return
	 */
	public ArrayList<CalVO> list_all_calendar();

	/**
	 * 조회
	 * 
	 * @param calno
	 * @return
	 */
	public CalVO read(int calno);

	/**
	 * 수정
	 * 
	 * @param calVO
	 * @return 수정된 레코드 갯수
	 */
	public int update(CalVO calVO);

	/**
	 * 삭제
	 * 
	 * @param calno 삭제할 레코드 PK 번호
	 * @return 삭제된 레코드 갯수
	 */
	public int delete(int calno);

}