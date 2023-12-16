package dev.mvc.articles;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Spring Boot가 자동 구현
 * 
 * @author me
 *
 */
public interface ArticlesDAOInter {
	/**
	 * 등록, 추상 메소드
	 * 
	 * @param articlesVO
	 * @return
	 */
	public int create(ArticlesVO articlesVO);

	/**
	 * 모든 카테고리의 등록된 글목록
	 * 
	 * @return
	 */
	public ArrayList<ArticlesVO> list_all();

	/**
	 * 카테고리별 등록된 글 목록
	 * 
	 * @param topicno
	 * @return
	 */
	public ArrayList<ArticlesVO> list_by_topicno(int topicno);

	/**
	 * 조회
	 * 
	 * @param articlesno
	 * @return
	 */
	public ArticlesVO read(int articlesno);

	/**
	 * map 등록, 수정, 삭제
	 * 
	 * @param map
	 * @return 수정된 레코드 갯수
	 */
	public int map(HashMap<String, Object> map);

	/**
	 * youtube 등록, 수정, 삭제
	 * 
	 * @param youtube
	 * @return 수정된 레코드 갯수
	 */
	public int youtube(HashMap<String, Object> map);

	/**
	 * 카테고리별 검색 목록
	 * 
	 * @param map
	 * @return
	 */
	public ArrayList<ArticlesVO> list_by_topicno_search(HashMap<String, Object> hashMap);

	/**
	 * 카테고리별 검색된 레코드 갯수
	 * 
	 * @param map
	 * @return
	 */
	public int search_count(HashMap<String, Object> hashMap);

	/**
	 * 카테고리별 검색 목록 + 페이징
	 * 
	 * @param articlesVO
	 * @return
	 */
	public ArrayList<ArticlesVO> list_by_topicno_search_paging(ArticlesVO articlesVO);

	/**
	 * 패스워드 검사
	 * 
	 * @param hashMap
	 * @return
	 */
	public int password_check(HashMap<String, Object> hashMap);

	/**
	 * 글 정보 수정
	 * 
	 * @param articlesVO
	 * @return 처리된 레코드 갯수
	 */
	public int update_text(ArticlesVO articlesVO);

	/**
	 * 파일 정보 수정
	 * 
	 * @param articlesVO
	 * @return 처리된 레코드 갯수
	 */
	public int update_file(ArticlesVO articlesVO);

	/**
	 * 삭제
	 * 
	 * @param articlesno
	 * @return 삭제된 레코드 갯수
	 */
	public int delete(int articlesno);

	/**
	 * FK topicno 값이 같은 레코드 갯수 산출
	 * 
	 * @param topicno
	 * @return
	 */
	public int count_by_topicno(int topicno);

	/**
	 * 특정 카테고리에 속한 모든 레코드 삭제
	 * 
	 * @param topicno
	 * @return 삭제된 레코드 갯수
	 */
	public int delete_by_topicno(int topicno);

}
