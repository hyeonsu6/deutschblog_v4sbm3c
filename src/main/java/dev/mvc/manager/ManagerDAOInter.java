package dev.mvc.manager;

public interface ManagerDAOInter {
	/**
	 * 로그인
	 * 
	 * @param ManagerVO
	 * @return
	 */
	public int login(ManagerVO managerVO);

	/**
	 * 회원 정보
	 * 
	 * @param String
	 * @return
	 */
	public ManagerVO read_by_id(String id);

	/**
	 * 회원 정보 조회
	 * 
	 * @param managerVOno
	 * @return
	 */
	public ManagerVO read(int managerno);

}
