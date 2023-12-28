package dev.mvc.topic;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.articles.Articles;
import dev.mvc.articles.ArticlesProcInter;
import dev.mvc.articles.ArticlesVO;
import dev.mvc.manager.ManagerProcInter;
import dev.mvc.tool.Tool;

@Controller
public class TopicCont {
	@Autowired // TopicProcInter interface 구현한 객체를 만들어 자동으로 할당해라.
	@Qualifier("dev.mvc.topic.TopicProc")
	private TopicProcInter topicProc;

	@Autowired
	@Qualifier("dev.mvc.manager.ManagerProc") // "dev.mvc.manager.ManagerProc"라고 명명된 클래스
	private ManagerProcInter managerProc; // ManagerProcInter를 구현한 ManagerProc 클래스의 객체를 자동으로 생성하여 할당

	@Autowired
	@Qualifier("dev.mvc.articles.ArticlesProc") // @Component("dev.mvc.articles.ArticlesProc")
	private ArticlesProcInter articlesProc;

	public TopicCont() {
		System.out.println("-> TopicCont created.");
	}

//  // FORM 출력, http://localhost:9092/topic/create.do
//  @RequestMapping(value="/topic/create.do", method = RequestMethod.GET)
//  @ResponseBody // 단순 문자열로 출력, jsp 파일명 조합이 발생하지 않음.
//  public String create() {
//    return "<h3>GET 방식 FORM 출력</h3>";
//  }

	// FORM 출력, http://localhost:9092/topic/create.do
	@RequestMapping(value = "/topic/create.do", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/topic/create"); // /WEB-INF/views/topic/create.jsp

		return mav;
	}

	// FORM 데이터 처리, http://localhost:9092/topic/create.do
	@RequestMapping(value = "/topic/create.do", method = RequestMethod.POST)
	public ModelAndView create(TopicVO topicVO) { // 자동으로 topicVO 객체가 생성되고 폼의 값이 할당됨
		ModelAndView mav = new ModelAndView();

		int cnt = this.topicProc.create(topicVO);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			// mav.addObject("code", "create_success"); // 키, 값
			// mav.addObject("name", topicVO.getName()); // 카테고리 이름 jsp로 전송
			mav.setViewName("redirect:/topic/list_all.do"); // 주소 자동 이동
		} else {
			mav.addObject("code", "create_fail");
			mav.setViewName("/topic/msg"); // /WEB-INF/views/topic/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 전체 목록 http://localhost:9092/topic/list_all.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/topic/list_all.do", method = RequestMethod.GET)
	public ModelAndView list_all(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session) == true) {
			mav.setViewName("/topic/list_all"); // /WEB-INF/views/topic/list_all.jsp

			ArrayList<TopicVO> list = this.topicProc.list_all();
			mav.addObject("list", list);

		} else {
			mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp

		}

		return mav;
	}

	/**
	 * 전체 목록 http://localhost:9093/topic/list_all_member.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/topic/list_all_member.do", method = RequestMethod.GET)
	public ModelAndView list_all_member() {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/topic/list_all_member"); // /WEB-INF/views/fcate/list_all_member.jsp

		ArrayList<TopicVO> list = this.topicProc.list_all_member();
		mav.addObject("list", list);

		return mav;
	}

	/**
	 * 조회 http://localhost:9092/topic/read.do?topicno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/topic/read.do", method = RequestMethod.GET)
	public ModelAndView read(int topicno) { // int topicno = (int)request.getParameter("topicno");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/topic/read"); // /WEB-INF/views/topic/read.jsp

		TopicVO topicVO = this.topicProc.read(topicno);
		mav.addObject("topicVO", topicVO);

		return mav;
	}

	/**
	 * 수정폼 http://localhost:9092/topic/update.do?topicno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/topic/update.do", method = RequestMethod.GET)
	public ModelAndView update(HttpSession session, int topicno) { // int topicno =
																	// (int)request.getParameter("topicno");
		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session) == true) {
			// mav.setViewName("/topic/update"); // /WEB-INF/views/topic/update.jsp
			mav.setViewName("/topic/list_all_update"); // /WEB-INF/views/topic/list_all_update.jsp

			TopicVO topicVO = this.topicProc.read(topicno);
			mav.addObject("topicVO", topicVO);

			ArrayList<TopicVO> list = this.topicProc.list_all();
			mav.addObject("list", list);

		} else {
			mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp

		}

		return mav;
	}

	/**
	 * 수정 처리, http://localhost:9092/topic/update.do
	 * 
	 * @param topicVO 수정할 내용
	 * @return
	 */
	@RequestMapping(value = "/topic/update.do", method = RequestMethod.POST)
	public ModelAndView update(TopicVO topicVO) { // 자동으로 topicVO 객체가 생성되고 폼의 값이 할당됨
		ModelAndView mav = new ModelAndView();

		int cnt = this.topicProc.update(topicVO); // 수정 처리
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			// mav.addObject("code", "update_success"); // 키, 값
			// mav.addObject("name", topicVO.getName()); // 카테고리 이름 jsp로 전송
			mav.setViewName("redirect:/topic/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/topic/msg"); // /WEB-INF/views/topic/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 삭제폼 http://localhost:9092/topic/delete.do?topicno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/topic/delete.do", method = RequestMethod.GET)
	public ModelAndView delete(HttpSession session, int topicno) { // int topicno =
																	// (int)request.getParameter("topicno");
		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session) == true) {
			// mav.setViewName("/topic/delete"); // /WEB-INF/views/topic/delete.jsp
			mav.setViewName("/topic/list_all_delete"); // /WEB-INF/views/topic/list_all_delete.jsp

			TopicVO topicVO = this.topicProc.read(topicno);
			mav.addObject("topicVO", topicVO);

			ArrayList<TopicVO> list = this.topicProc.list_all();
			mav.addObject("list", list);

			// 특정 카테고리에 속한 레코드 갯수를 리턴
			int count_by_topicno = this.articlesProc.count_by_topicno(topicno);
			mav.addObject("count_by_topicno", count_by_topicno);

		} else {
			mav.setViewName("/manager/login_need"); // /WEB-INF/views/admin/login_need.jsp

		}

		return mav;
	}

	// 삭제 처리, 수정 처리를 복사하여 개발
	// 자식 테이블 레코드 삭제 -> 부모 테이블 레코드 삭제
	/**
	 * 카테고리 삭제
	 * 
	 * @param session
	 * @param topicno 삭제할 카테고리 번호
	 * @return
	 */
	@RequestMapping(value = "/topic/delete.do", method = RequestMethod.POST)
	public ModelAndView delete_proc(HttpSession session, int topicno) { // <form> 태그의 값이 자동으로 저장됨
//   System.out.println("-> topicno: " + topicVO.getTopicno());
//   System.out.println("-> name: " + topicVO.getName());

		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session) == true) {
			ArrayList<ArticlesVO> list = this.articlesProc.list_by_topicno(topicno); // 자식 레코드 목록 읽기

			for (ArticlesVO articlesVO : list) { // 자식 레코드 관련 파일 삭제
				// -------------------------------------------------------------------
				// 파일 삭제 시작
				// -------------------------------------------------------------------
				String file1saved = articlesVO.getFile1saved();
				String thumb1 = articlesVO.getThumb1();

				String uploadDir = Articles.getUploadDir();
				Tool.deleteFile(uploadDir, file1saved); // 실제 저장된 파일삭제
				Tool.deleteFile(uploadDir, thumb1); // preview 이미지 삭제
				// -------------------------------------------------------------------
				// 파일 삭제 종료
				// -------------------------------------------------------------------
			}

			this.articlesProc.delete_by_topicno(topicno); // 자식 레코드 삭제

			int cnt = this.topicProc.delete(topicno); // 카테고리 삭제

			if (cnt == 1) {
				mav.setViewName("redirect:/topic/list_all.do"); // 자동 주소 이동, Spring 재호출

			} else {
				mav.addObject("code", "delete_fail");
				mav.setViewName("/topic/msg"); // /WEB-INF/views/topic/msg.jsp
			}

			mav.addObject("cnt", cnt);

		} else {
			mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
		}

		return mav;
	}

	/**
	 * 우선 순위 높임, 10 등 -> 1 등,
	 * http://localhost:9092/topic/update_seqno_forward.do?topicno=1
	 * 
	 * @param topicVO 수정할 내용
	 * @return
	 */
	@RequestMapping(value = "/topic/update_seqno_forward.do", method = RequestMethod.GET)
	public ModelAndView update_seqno_forward(int topicno) {
		ModelAndView mav = new ModelAndView();

		int cnt = this.topicProc.update_seqno_forward(topicno);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/topic/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/topic/msg"); // /WEB-INF/views/topic/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 우선 순위 낮춤, 1 등 -> 10 등,
	 * http://localhost:9092/topic/update_seqno_backward.do?topicno=1
	 * 
	 * @param topicno 수정할 레코드 PK 번호
	 * @return
	 */
	@RequestMapping(value = "/topic/update_seqno_backward.do", method = RequestMethod.GET)
	public ModelAndView update_seqno_backward(int topicno) {
		ModelAndView mav = new ModelAndView();

		int cnt = this.topicProc.update_seqno_backward(topicno);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/topic/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/topic/msg"); // /WEB-INF/views/topic/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 카테고리 공개 설정, http://localhost:9092/topic/update_visible_y.do?topicno=1
	 * 
	 * @param topicno 수정할 레코드 PK 번호
	 * @return
	 */
	@RequestMapping(value = "/topic/update_visible_y.do", method = RequestMethod.GET)
	public ModelAndView update_visible_y(int topicno) {
		ModelAndView mav = new ModelAndView();

		int cnt = this.topicProc.update_visible_y(topicno);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/topic/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/topic/msg"); // /WEB-INF/views/topic/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 카테고리 비공개 설정, http://localhost:9092/topic/update_visible_n.do?topicno=1
	 * 
	 * @param topicno 수정할 레코드 PK 번호
	 * @return
	 */
	@RequestMapping(value = "/topic/update_visible_n.do", method = RequestMethod.GET)
	public ModelAndView update_visible_n(int topicno) {
		ModelAndView mav = new ModelAndView();

		int cnt = this.topicProc.update_visible_n(topicno);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/topic/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/topic/msg"); // /WEB-INF/views/topic/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	// FORM 출력, http://localhost:9092/topic/aboutme.do
	@RequestMapping(value = "/topic/aboutme.do", method = RequestMethod.GET)
	public ModelAndView aboutme() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/topic/aboutme"); // /WEB-INF/views/topic/aboutme.jsp

		return mav;
	}

}
