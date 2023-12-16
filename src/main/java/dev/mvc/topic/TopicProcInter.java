package dev.mvc.topic;

import java.util.ArrayList;

public interface TopicProcInter {
	/**
	 * 등록, 추상 메소드 -> Spring Boot이 구현함.
	 * 
	 * @param topicVO 객체
	 * @return 등록된 레코드 갯수
	 */
	public int create(TopicVO topicVO);

	/**
	 * 전체 목록
	 * 
	 * @return
	 */
	public ArrayList<TopicVO> list_all();

	/**
	 * 조회
	 * 
	 * @param topicno
	 * @return
	 */
	public TopicVO read(int topicno);

	/**
	 * 수정
	 * 
	 * @param TopicVO
	 * @return 수정된 레코드 갯수
	 */
	public int update(TopicVO topicVO);

	/**
	 * 삭제
	 * 
	 * @param topicno 삭제할 레코드 PK 번호
	 * @return 삭제된 레코드 갯수
	 */
	public int delete(int topicno);

	/**
	 * 우선 순위 높임, 10 등 -> 1 등
	 * 
	 * @param topicno
	 * @return 수정된 레코드 갯수
	 */
	public int update_seqno_forward(int topicno);

	/**
	 * 우선 순위 낮춤, 1 등 -> 10 등
	 * 
	 * @param topicno
	 * @return 수정된 레코드 갯수
	 */
	public int update_seqno_backward(int topicno);

	/**
	 * 카테고리 공개 설정
	 * 
	 * @param topicno
	 * @return
	 */
	public int update_visible_y(int topicno);

	/**
	 * 카테고리 비공개 설정
	 * 
	 * @param topicno
	 * @return
	 */
	public int update_visible_n(int topicno);

	/**
	 * 비회원/회원 SELECT LIST
	 * 
	 * @return
	 */
	public ArrayList<TopicVO> list_all_y();

}
