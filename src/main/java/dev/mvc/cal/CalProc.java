package dev.mvc.cal;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//Controller가 사용하는 이름
@Component("dev.mvc.cal.CalProc")
public class CalProc implements CalProcInter {
	@Autowired		// CalDAOInter interface 구현한 객체를 만들어 자동으로 할당해라.
	private CalDAOInter calDAO;

	@Override
	public int create(CalVO calVO) {
		int cnt = this.calDAO.create(calVO);
		return cnt;
	}

	@Override
	public ArrayList<CalVO> list_all() {
		ArrayList<CalVO> list = this.calDAO.list_all();
		return list;
	}
	
	@Override
	public ArrayList<CalVO> list_all_calendar() {
		ArrayList<CalVO> list = this.calDAO.list_all_calendar();
		return list;
	}

	@Override
	public CalVO read(int calno) {
		CalVO calVO = this.calDAO.read(calno);
		return calVO;
	}

	@Override
	public int update(CalVO calVO) {
		int cnt = this.calDAO.update(calVO);
		return cnt;
	}

	@Override
	public int delete(int calno) {
		int cnt = this.calDAO.delete(calno);
		return cnt;
	}

}
