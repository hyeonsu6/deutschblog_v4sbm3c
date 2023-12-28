package dev.mvc.cal;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.cal.CalProc")
public class CalProc implements CalProcInter {
	@Autowired
	private CalDAOInter calDAO;

	@Override
	public ArrayList<CalVO> callist(String id, String yyyyMM) {
		return calDAO.callist(id, yyyyMM);
	}

	@Override
	public CalVO detail(int seq) {
		return calDAO.detail(seq);
	}

	@Override
	public int write(CalVO calVO) {
		return calDAO.write(calVO);
	}

	@Override
	public int delete(int seq) {
		return calDAO.delete(seq);
	}

	@Override
	public int update(CalVO calVO) {
		return calDAO.update(calVO);
	}

	@Override
	public ArrayList<CalVO> daylist(String id, String yyyyMMdd) {
		return calDAO.daylist(id, yyyyMMdd);
	}
}
