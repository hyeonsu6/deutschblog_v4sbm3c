package dev.mvc.german;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.german.GermanProc")
public class GermanProc implements GermanProcInter {
	@Autowired
	private GermanDAOInter germanDAO;

	public GermanProc() {
		// System.out.println("-> GermanProc created.");
	}

	@Override
	public int checkID(String id) {
		int cnt = this.germanDAO.checkID(id);
		return cnt;
	}

	@Override
	public int create(GermanVO germanVO) {
		int cnt = this.germanDAO.create(germanVO);
		return cnt;
	}

	@Override
	public ArrayList<GermanVO> list() {
		ArrayList<GermanVO> list = this.germanDAO.list();
		return list;
	}

	@Override
	public GermanVO read(int germanno) {
		GermanVO germanVO = this.germanDAO.read(germanno);
		return germanVO;
	}

	@Override
	public GermanVO readById(String id) {
		GermanVO germanVO = this.germanDAO.readById(id);
		return germanVO;
	}

	@Override
	public boolean isGerman(HttpSession session) {
		boolean sw = false; // 로그인하지 않은 것으로 초기화
		int grade = 99;

		// System.out.println("-> grade: " + session.getAttribute("grade"));
		if (session != null) {
			String id = (String) session.getAttribute("id");
			if (session.getAttribute("grade") != null) {
				grade = (int) session.getAttribute("grade");
			}

			if (id != null && grade <= 20) { // 관리자 + 회원
				sw = true; // 로그인 한 경우
			}
		}

		return sw;
	}

	@Override
	public boolean isGermanManager(HttpSession session) {
		boolean sw = false; // 로그인하지 않은 것으로 초기화
		int grade = 99;

		// System.out.println("-> grade: " + session.getAttribute("grade"));
		if (session != null) {
			String id = (String) session.getAttribute("id");
			if (session.getAttribute("grade") != null) {
				grade = (int) session.getAttribute("grade");
			}

			if (id != null && grade <= 10) { // 관리자
				sw = true; // 로그인 한 경우
			}
		}

		return sw;
	}

	@Override
	public int update(GermanVO germanVO) {
		int cnt = this.germanDAO.update(germanVO);
		return cnt;
	}

	@Override
	public int delete(int germanno) {
		int cnt = this.germanDAO.delete(germanno);
		return cnt;
	}

	@Override
	public int login(HashMap<String, Object> map) {
		int cnt = this.germanDAO.login(map);
		return cnt;
	}

	@Override
	public int passwd_check(HashMap<String, Object> map) {
		int cnt = this.germanDAO.passwd_check(map);
		return cnt;
	}

	@Override
	public int passwd_update(HashMap<String, Object> map) {
		int cnt = this.germanDAO.passwd_update(map);
		return cnt;
	}

	@Override
	public int findId(HashMap<String, Object> map) {
		int cnt = this.germanDAO.findId(map);		
		return cnt;
	}
}
