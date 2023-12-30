package dev.mvc.cal;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.manager.ManagerProcInter;

@Controller
public class CalCont {
	@Autowired
	@Qualifier("dev.mvc.manager.ManagerProc")
	private ManagerProcInter managerProc;

	@Autowired
	@Qualifier("dev.mvc.cal.CalProc")
	private CalProcInter calProc;

	public CalCont() {
		System.out.println("-> CalCont created.");
	}

	/**
	 * 등록 폼 FORM 출력, http://localhost:9092/calendar/create.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar/create.do", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/calendar/create"); // /WEB-INF/views/calendar/create.jsp

		return mav;
	}

	/**
	 * 등록 처리 FORM 데이터 처리, http://localhost:9092/calendar/create.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar/create.do", method = RequestMethod.POST)
	public ModelAndView create(CalVO calVO) { // 자동으로 CalVO 객체가 생성되고 폼의 값이 할당됨
		ModelAndView mav = new ModelAndView();

		int cnt = this.calProc.create(calVO);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/calendar/list_all_calendar.do"); // 주소 자동 이동
		} else {
			mav.addObject("code", "create_fail");
			mav.setViewName("/calendar/msg"); // /WEB-INF/views/calendar/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 전체 목록 http://localhost:9092/calendar/list_all.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar/list_all.do", method = RequestMethod.GET)
	public ModelAndView list_all(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session)) {
			mav.setViewName("/calendar/list_all");

			ArrayList<CalVO> list = this.calProc.list_all();
			mav.addObject("list", list);
		} else {
			mav.setViewName("/calendar/msg");
		}

		return mav;
	}

	/**
	 * 전체 목록 http://localhost:9092/calendar/list_all_calendar.do 달력형
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar/list_all_calendar.do", method = RequestMethod.GET)
	public ModelAndView list_all_calendar(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/calendar/list_all_calendar");

		ArrayList<CalVO> list = this.calProc.list_all_calendar();
		mav.addObject("list", list); // 이벤트 데이터를 ModelAndView에 추가

		return mav;
	}

	/**
	 * 조회 http://localhost:9092/calendar/read.do?calno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar/read.do", method = RequestMethod.GET)
	public ModelAndView read(int calno) { // int calno = (int)request.getParameter("calno");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/calendar/read"); // /WEB-INF/views/calendar/read.jsp

		CalVO calVO = this.calProc.read(calno);
		mav.addObject("calVO", calVO);

		return mav;
	}

	/**
	 * 수정폼 http://localhost:9092/calendar/update.do?calno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar/update.do", method = RequestMethod.GET)
	public ModelAndView updateForm(HttpSession session, int calno) {
		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session)) { // 관리자 로그인 확인
			CalVO calVO = this.calProc.read(calno); // 해당 calno에 대한 데이터 읽어오기
			mav.addObject("calVO", calVO);
			mav.setViewName("/calendar/update"); // /WEB-INF/views/calendar/update.jsp
		} else { // 정상적인 로그인이 아닌 경우 로그인 유도
			mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
			mav.setViewName("redirect:/calendar/msg.do");
		}

		return mav; // forward
	}

	/**
	 * 수정 처리 http://localhost:9092/calendar/update.do?calno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar/update.do", method = RequestMethod.POST)
	public ModelAndView update(HttpSession session, CalVO calVO) {
		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session)) {
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("calno", calVO.getCalno());

			if (this.managerProc.isManager(session)) {
				this.calProc.update(calVO);

				mav.addObject("calno", calVO.getCalno());
				mav.setViewName("redirect:/calendar/read.do");
			} else {
				mav.addObject("code", "passwd_fail");
				mav.addObject("cnt", 0);
				mav.addObject("url", "/calendar/msg");
				mav.setViewName("redirect:/update/msg.do");
			}
		} else {
			mav.addObject("url", "/manager/login_need");
			mav.setViewName("redirect:/update/msg.do");
		}

		return mav;
	}

	/**
	 * 삭제폼 http://localhost:9092/calendar/delete.do?calno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/calendar/delete.do", method = RequestMethod.GET)
	public ModelAndView delete(HttpSession session, int calno) { // int calno = (int)request.getParameter("calno");
		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session) == true) {
			mav.setViewName("/calendar/delete"); // /WEB-INF/views/calendar/delete.jsp

			CalVO calVO = this.calProc.read(calno);
			mav.addObject("calVO", calVO);

			ArrayList<CalVO> list = this.calProc.list_all();
			mav.addObject("list", list);

		} else {
			mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp

		}
		return mav;
	}

	/**
	 * 삭제 처리, http://localhost:9092/calendar/delete.do?calno=1
	 * 
	 * @param calno 삭제할 레코드 번호
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/calendar/delete.do", method = RequestMethod.POST)
	public ModelAndView delete_proc(HttpSession session, int calno) { // <form> 태그의 값이 자동으로 저장됨

		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session) == true) {
			int cnt = this.calProc.delete(calno); // 카테고리 삭제

			if (cnt == 1) {
				mav.setViewName("redirect:/calendar/list_all_calendar.do"); // 자동 주소 이동, Spring 재호출

			} else {
				mav.addObject("code", "delete_fail");
				mav.setViewName("/calendar/msg"); // /WEB-INF/views/topic/msg.jsp
			}

			mav.addObject("cnt", cnt);

		} else {
			mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
		}

		return mav;
	}
}
