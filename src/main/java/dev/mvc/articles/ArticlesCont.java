package dev.mvc.articles;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.topic.TopicProcInter;
import dev.mvc.topic.TopicVO;
import dev.mvc.manager.ManagerProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ArticlesCont {
	@Autowired
	@Qualifier("dev.mvc.manager.ManagerProc") // @Component("dev.mvc.manager.ManagerProc")
	private ManagerProcInter managerProc;

	@Autowired
	@Qualifier("dev.mvc.topic.TopicProc") // @Component("dev.mvc.topic.TopicProc")
	private TopicProcInter topicProc;

	@Autowired
	@Qualifier("dev.mvc.articles.ArticlesProc") // @Component("dev.mvc.articles.ArticlesProc")
	private ArticlesProcInter articlesProc;

	public ArticlesCont () {
	    System.out.println("-> ArticlesCont created.");
	  }

	/**
	 * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근 POST → url → GET →
	 * 데이터 전송
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/msg.do", method = RequestMethod.GET)
	public ModelAndView msg(String url) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName(url); // forward

		return mav; // forward
	}

	// 등록 폼, contents 테이블은 FK로 topicno를 사용함.
	// http://localhost:9092/articles/create.do X
	// http://localhost:9092/articles/create.do?topicno=1 // topicno 변수값을 보내는 목적
	// http://localhost:9092/articles/create.do?topicno=2
	// http://localhost:9092/articles/create.do?topicno=3
	@RequestMapping(value = "/articles/create.do", method = RequestMethod.GET)
	public ModelAndView create(int topicno) {
		// public ModelAndView create(HttpServletRequest request, int topicno) {
		ModelAndView mav = new ModelAndView();

		TopicVO topicVO = this.topicProc.read(topicno); // create.jsp에 카테고리 정보를 출력하기위한 목적
		mav.addObject("topicVO", topicVO);
//	    request.setAttribute("topicVO", topicVO);

		mav.setViewName("/articles/create"); // /webapp/WEB-INF/views/articles/create.jsp

		return mav;
	}

	/**
	 * 등록 처리 http://localhost:9092/articles/create.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/create.do", method = RequestMethod.POST)
	public ModelAndView create(HttpServletRequest request, HttpSession session, ArticlesVO articlesVO) {
		ModelAndView mav = new ModelAndView();

		if (managerProc.isManager(session)) { // 관리자로 로그인한경우
			// ------------------------------------------------------------------------------
			// 파일 전송 코드 시작
			// ------------------------------------------------------------------------------
			String file1 = ""; // 원본 파일명 image
			String file1saved = ""; // 저장된 파일명, image
			String thumb1 = ""; // preview image

			String upDir = Articles.getUploadDir(); // 파일을 업로드할 폴더 준비
			System.out.println("-> upDir: " + upDir);

			// 전송 파일이 없어도 file1MF 객체가 생성됨.
			// <input type='file' class="form-control" name='file1MF' id='file1MF'
			// value='' placeholder="파일 선택">
			MultipartFile mf = articlesVO.getFile1MF();

			file1 = mf.getOriginalFilename(); // 원본 파일명 산출, 01.jpg
			System.out.println("-> 원본 파일명 산출 file1: " + file1);

			if (Tool.checkUploadFile(file1) == true) { // 업로드 가능한 파일인지 검사
				long size1 = mf.getSize(); // 파일 크기

				if (size1 > 0) { // 파일 크기 체크
					// 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
					file1saved = Upload.saveFileSpring(mf, upDir);

					if (Tool.isImage(file1saved)) { // 이미지인지 검사
						// thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
						thumb1 = Tool.preview(upDir, file1saved, 200, 150);
					}

				}

				articlesVO.setFile1(file1); // 순수 원본 파일명
				articlesVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
				articlesVO.setThumb1(thumb1); // 원본이미지 축소판
				articlesVO.setSize1(size1); // 파일 크기
				// ------------------------------------------------------------------------------
				// 파일 전송 코드 종료
				// ------------------------------------------------------------------------------

				// Call By Reference: 메모리 공유, Hashcode 전달
				int managerno = (int) session.getAttribute("managerno"); // managerno FK
				articlesVO.setManagerno(managerno);
				int cnt = this.articlesProc.create(articlesVO);

				// ------------------------------------------------------------------------------
				// PK의 return
				// ------------------------------------------------------------------------------
				// System.out.println("--> managerno: " + articlesVO.getArticlesVO());
				// mav.addObject("managerno", articlesVO.getArticlesVO()); // redirect
				// parameter 적용
				// ------------------------------------------------------------------------------

				if (cnt == 1) {
					mav.addObject("code", "create_success");
					// cateProc.increaseCnt(articlesVO.getTopicno()); // 글수 증가
				} else {
					mav.addObject("code", "create_fail");
				}
				mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

				// System.out.println("--> topicno: " + articlesVO.getTopicno());
				// redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
				mav.addObject("topicno", articlesVO.getTopicno()); // redirect parameter 적용

				mav.addObject("url", "/articles/msg"); // msg.jsp, redirect parameter 적용
				mav.setViewName("redirect:/articles/msg.do"); // Post -> Get - param...
			} else {
				mav.addObject("cnt", "0"); // 업로드 할 수 없는 파일
				mav.addObject("code", "check_upload_file_fail"); // 업로드 할 수 없는 파일
				mav.addObject("url", "/articles/msg"); // msg.jsp, redirect parameter 적용
				mav.setViewName("redirect:/articles/msg.do"); // Post -> Get - param...
			}
		} else {
			mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
			mav.setViewName("redirect:/manager/msg.do");
		}

		return mav; // forward
	}

	/**
	 * 전체 목록, 관리자만 사용 가능 http://localhost:9092/articles/list_all.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/list_all.do", method = RequestMethod.GET)
	public ModelAndView list_all(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		if (this.managerProc.isManager(session) == true) {
			mav.setViewName("/articles/list_all"); // /WEB-INF/views/articles/list_all.jsp

			ArrayList<ArticlesVO> list = this.articlesProc.list_all();

			// for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
			for (ArticlesVO articlesVO : list) {
				String title = articlesVO.getTitle();
				String article = articlesVO.getArticle();

				title = Tool.convertChar(title); // 특수 문자 처리
				article = Tool.convertChar(article);

				articlesVO.setTitle(title);
				articlesVO.setArticle(article);

			}

			mav.addObject("list", list);

		} else {
			mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp

		}

		return mav;
	}

	// /**
	// * 특정 카테고리의 검색 목록
	// * http://localhost:9092/articles/list_by_topicno.do?topicno=1
	// * @return
	// */
	// @RequestMapping(value="/articles/list_by_topicno.do", method =
	// RequestMethod.GET)
	// public ModelAndView list_by_topicno(int topicno, String word) {
//	    ModelAndView mav = new ModelAndView();
	//
//	    mav.setViewName("/articles/list_by_topicno"); // /WEB-INF/views/articles/list_by_topicno.jsp
	//
//	    TopicVO topicVO = this.topicProc.read(topicno); // create.jsp에 카테고리 정보를 출력하기위한 목적
//	    mav.addObject("topicVO", topicVO);
//	    // request.setAttribute("topicVO", topicVO);
	//
//	    // 검색하지 않는 경우
//	    // ArrayList<ArticlesVO> list = this.articlesVOProc.list_by_topicno(topicno);
	//
//	    // 검색하는 경우
//	    HashMap<String, Object> hashMap = new HashMap<String, Object>();
//	    hashMap.put("topicno", topicno);
//	    hashMap.put("word", word);
	//
//	    ArrayList<ArticlesVO> list = this.articlesVOProc.list_by_topicno_search(hashMap);
	//
//	    // for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
//	    for (ArticlesVO articlesVO : list) {
//	      String title = articlesVO.getTitle();
//	      String article = articlesVO.getArticle();
//	      
//	      title = Tool.convertChar(title);  // 특수 문자 처리
//	      article = Tool.convertChar(article); 
//	      
//	      contentsVO.setTitle(title);
//	      contentsVO.setArticle(article);  
	//
//	    }
	//
//	    mav.addObject("list", list);
	//
//	    return mav;
	// }

	/**
	 * 목록 + 검색 + 페이징 지원 검색하지 않는 경우
	 * http://localhost:9092/articles/list_by_topicno.do?topicno=2&word=&now_page=1
	 * 검색하는 경우
	 * http://localhost:9092/articles/list_by_topicno.do?topicno=2&word=탐험&now_page=1
	 * 
	 * @param topicno
	 * @param word
	 * @param now_page
	 * @return
	 */
	@RequestMapping(value = "/articles/list_by_topicno.do", method = RequestMethod.GET)
	public ModelAndView list_by_topicno(ArticlesVO articlesVO) {
		ModelAndView mav = new ModelAndView();

		// 검색 목록
		ArrayList<ArticlesVO> list = articlesProc.list_by_topicno_search_paging(articlesVO);

		// for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
		for (ArticlesVO vo : list) {
			String title = vo.getTitle();
			String article = vo.getArticle();

			title = Tool.convertChar(title); // 특수 문자 처리
			article = Tool.convertChar(article);

			vo.setTitle(title);
			vo.setArticle(article);

		}

		mav.addObject("list", list);

		TopicVO topicVO = topicProc.read(articlesVO.getTopicno());
		mav.addObject("topicVO", topicVO);

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("topicno", articlesVO.getTopicno());
		hashMap.put("word", articlesVO.getWord());

		int search_count = this.articlesProc.search_count(hashMap); // 검색된 레코드 갯수 -> 전체 페이지 규모 파악
		mav.addObject("search_count", search_count);

		/*
		 * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
		 * 18 19 20 [다음]
		 * 
		 * @param cateno 카테고리번호
		 * 
		 * @param now_page 현재 페이지
		 * 
		 * @param word 검색어
		 * 
		 * @param list_file 목록 파일명
		 * 
		 * @return 페이징용으로 생성된 HTML/CSS tag 문자열
		 */
		String paging = articlesProc.pagingBox(articlesVO.getTopicno(), articlesVO.getNow_page(), articlesVO.getWord(),
				"list_by_topicno.do", search_count);
		mav.addObject("paging", paging);

		// mav.addObject("now_page", now_page);

		mav.setViewName("/articles/list_by_topicno"); // /articles/list_by_topicno.jsp

		return mav;
	}

	/**
	 * 목록 + 검색 + 페이징 지원 + Grid 검색하지 않는 경우
	 * http://localhost:9092/articles/list_by_topicno_grid.do?topicno=2&word=&now_page=1
	 * 검색하는 경우
	 * http://localhost:9092/articles/list_by_topicno_grid.do?topicno=2&word=탐험&now_page=1
	 * 
	 * @param topicno
	 * @param word
	 * @param now_page
	 * @return
	 */
	@RequestMapping(value = "/articles/list_by_topicno_grid.do", method = RequestMethod.GET)
	public ModelAndView list_by_topicno_grid(ArticlesVO articlesVO) {
		ModelAndView mav = new ModelAndView();

		// 검색 목록
		ArrayList<ArticlesVO> list = articlesProc.list_by_topicno_search_paging(articlesVO);

		// for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
		for (ArticlesVO vo : list) {
			String title = vo.getTitle();
			String article = vo.getArticle();

			title = Tool.convertChar(title); // 특수 문자 처리
			article = Tool.convertChar(article);

			vo.setTitle(title);
			vo.setArticle(article);

		}

		mav.addObject("list", list);

		TopicVO topicVO = topicProc.read(articlesVO.getTopicno());
		mav.addObject("topicVO", topicVO);

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("topicno", articlesVO.getTopicno());
		hashMap.put("word", articlesVO.getWord());

		int search_count = this.articlesProc.search_count(hashMap); // 검색된 레코드 갯수 -> 전체 페이지 규모 파악
		mav.addObject("search_count", search_count);

		/*
		 * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
		 * 18 19 20 [다음]
		 * 
		 * @param cateno 카테고리번호
		 * 
		 * @param now_page 현재 페이지
		 * 
		 * @param word 검색어
		 * 
		 * @param list_file 목록 파일명
		 * 
		 * @return 페이징용으로 생성된 HTML/CSS tag 문자열
		 */
		String paging = articlesProc.pagingBox(articlesVO.getTopicno(), articlesVO.getNow_page(), articlesVO.getWord(),
				"list_by_topicno_grid.do", search_count);
		mav.addObject("paging", paging);

		// mav.addObject("now_page", now_page);

		mav.setViewName("/articles/list_by_topicno_grid"); // /articles/list_by_topicno_grid.jsp

		return mav;
	}

	/**
	 * 조회 http://localhost:9092/articles/read.do?articlesno=17
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/read.do", method = RequestMethod.GET)
	public ModelAndView read(int articlesno) { // int articlesno = (int)request.getParameter("articlesno");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/articles/read"); // /WEB-INF/views/articles/read.jsp

		ArticlesVO articlesVO = this.articlesProc.read(articlesno);

		String title = articlesVO.getTitle();
		String article = articlesVO.getArticle();

		title = Tool.convertChar(title); // 특수 문자 처리
		article = Tool.convertChar(article);

		articlesVO.setTitle(title);
		articlesVO.setArticle(article);
		
		long size1 = articlesVO.getSize1();
		String size1_label = Tool.unit(size1);
		articlesVO.setSize1_label(size1_label);

		mav.addObject("articlesVO", articlesVO);

		TopicVO topicVO = this.topicProc.read(articlesVO.getTopicno());
		mav.addObject("topicVO", topicVO);

		return mav;
	}

	/**
	 * 맵 등록/수정/삭제 폼 http://localhost:9092/articles/map.do?articlesno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/map.do", method = RequestMethod.GET)
	public ModelAndView map(int articlesno) {
		ModelAndView mav = new ModelAndView();

		ArticlesVO articlesVO = this.articlesProc.read(articlesno); // map 정보 읽어 오기
		mav.addObject("articlesVO", articlesVO); // request.setAttribute("articlesVO", articlesVO);

		TopicVO topicVO = this.topicProc.read(articlesVO.getTopicno()); // 그룹 정보 읽기
		mav.addObject("topicVO", topicVO);

		mav.setViewName("/articles/map"); // /WEB-INF/views/articles/map.jsp

		return mav;
	}

	/**
	 * MAP 등록/수정/삭제 처리 http://localhost:9092/articles/map.do
	 * 
	 * @param articlesVO
	 * @return
	 */
	@RequestMapping(value = "/articles/map.do", method = RequestMethod.POST)
	public ModelAndView map_update(int articlesno, String map) {
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("articlesno", articlesno);
		hashMap.put("map", map);

		this.articlesProc.map(hashMap);

		mav.setViewName("redirect:/articles/read.do?articlesno=" + articlesno);
		// /webapp/WEB-INF/views/contents/read.jsp

		return mav;
	}

	/**
	 * Youtube 등록/수정/삭제 폼 http://localhost:9092/articles/map.do?articlesno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/youtube.do", method = RequestMethod.GET)
	public ModelAndView youtube(int articlesno) {
		ModelAndView mav = new ModelAndView();

		ArticlesVO articlesVO = this.articlesProc.read(articlesno); // map 정보 읽어 오기
		mav.addObject("articlesVO", articlesVO); // request.setAttribute("articlesVO", articlesVO);

		TopicVO topicVO = this.topicProc.read(articlesVO.getTopicno()); // 그룹 정보 읽기
		mav.addObject("topicVO", topicVO);

		mav.setViewName("/articles/youtube"); // /WEB-INF/views/articles/youtube.jsp

		return mav;
	}

	/**
	 * Youtube 등록/수정/삭제 처리 http://localhost:9092/articles/map.do
	 * 
	 * @param articlesno 글 번호
	 * @param youtube    Youtube url의 소스 코드
	 * @return
	 */
	@RequestMapping(value = "/articles/youtube.do", method = RequestMethod.POST)
	public ModelAndView youtube_update(int articlesno, String youtube) {
		ModelAndView mav = new ModelAndView();

		if (youtube.trim().length() > 0) { // 삭제 중인지 확인, 삭제가 아니면 youtube 크기 변경
			youtube = Tool.youtubeResize(youtube, 640); // youtube 영상의 크기를 width 기준 640 px로 변경
		}

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("articlesno", articlesno);
		hashMap.put("youtube", youtube);

		this.articlesProc.youtube(hashMap);

		mav.setViewName("redirect:/articles/read.do?articlesno=" + articlesno);
		// /webapp/WEB-INF/views/articles/read.jsp

		return mav;
	}

	/**
	 * 수정 폼 http://localhost:9092/articles/update_text.do?articlesno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/update_text.do", method = RequestMethod.GET)
	public ModelAndView update_text(HttpSession session, int articlesno) {
		ModelAndView mav = new ModelAndView();

		if (managerProc.isManager(session)) { // 관리자로 로그인한경우
			ArticlesVO articlesVO = this.articlesProc.read(articlesno);
			mav.addObject("articlesVO", articlesVO);

			TopicVO topicVO = this.topicProc.read(articlesVO.getTopicno());
			mav.addObject("topicVO", topicVO);

			mav.setViewName("/articles/update_text"); // /WEB-INF/views/articles/update_text.jsp
			// String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
			// mav.addObject("article", article);

		} else {
			mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
			mav.setViewName("redirect:/articles/msg.do");
		}

		return mav; // forward
	}

	/**
	 * 수정 처리 http://localhost:9092/articles/update_text.do?articlesno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/update_text.do", method = RequestMethod.POST)
	public ModelAndView update_text(HttpSession session, ArticlesVO articlesVO) {
		ModelAndView mav = new ModelAndView();

		// System.out.println("-> word: " + contentsVO.getWord());

		if (this.managerProc.isManager(session)) { // 관리자 로그인 확인
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("articlesno", articlesVO.getArticlesno());
			hashMap.put("pw", articlesVO.getPw());

			if (this.articlesProc.password_check(hashMap) == 1) { // 패스워드 일치
				this.articlesProc.update_text(articlesVO); // 글수정

				// mav 객체 이용
				mav.addObject("articlesno", articlesVO.getArticlesno());
				mav.addObject("topicno", articlesVO.getTopicno());
				mav.setViewName("redirect:/articles/read.do"); // 페이지 자동 이동

			} else { // 패스워드 불일치
				mav.addObject("code", "passwd_fail");
				mav.addObject("cnt", 0);
				mav.addObject("url", "/articles/msg"); // msg.jsp, redirect parameter 적용
				mav.setViewName("redirect:/articles/msg.do"); // POST -> GET -> JSP 출력
			}
		} else { // 정상적인 로그인이 아닌 경우 로그인 유도
			mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
			mav.setViewName("redirect:/articles/msg.do");
		}

		mav.addObject("now_page", articlesVO.getNow_page()); // POST -> GET: 데이터 분실이 발생함으로 다시하번 데이터 저장 ★

		// URL에 파라미터의 전송
		// mav.setViewName("redirect:/articles/read.do?articlesno=" +
		// contentsVO.getArticlesno() + "&topicno=" + articlesVO.getTopicno());

		return mav; // forward
	}

	/**
	 * 파일 수정 폼 http://localhost:9092/articles/update_file.do?articlesno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/articles/update_file.do", method = RequestMethod.GET)
	public ModelAndView update_file(HttpSession session, int articlesno) {
		ModelAndView mav = new ModelAndView();

		if (managerProc.isManager(session)) { // 관리자로 로그인한경우
			ArticlesVO articlesVO = this.articlesProc.read(articlesno);
			mav.addObject("articlesVO", articlesVO);

			TopicVO topicVO = this.topicProc.read(articlesVO.getTopicno());
			mav.addObject("topicVO", topicVO);

			mav.setViewName("/articles/update_file"); // /WEB-INF/views/articles/update_file.jsp

		} else {
			mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
			mav.setViewName("redirect:/articles/msg.do");
		}

		return mav; // forward
	}
	
	/**
	   * 파일 수정 처리 http://localhost:9092/articles/update_file.do
	   * 
	   * @return
	   */
	  @RequestMapping(value = "/articles/update_file.do", method = RequestMethod.POST)
	  public ModelAndView update_file(HttpSession session, ArticlesVO articlesVO) {
	    ModelAndView mav = new ModelAndView();
	    
	    if (this.managerProc.isManager(session)) {
	      // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
	    	ArticlesVO articlesVO_old = articlesProc.read(articlesVO.getArticlesno());
	      
	      // -------------------------------------------------------------------
	      // 파일 삭제 시작
	      // -------------------------------------------------------------------
	      String file1saved = articlesVO_old.getFile1saved();  // 실제 저장된 파일명
	      String thumb1 = articlesVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
	      long size1 = 0;
	         
	      String upDir =  Articles.getUploadDir();
	      
	      Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
	      Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
	      // -------------------------------------------------------------------
	      // 파일 삭제 종료
	      // -------------------------------------------------------------------
	          
	      // -------------------------------------------------------------------
	      // 파일 전송 시작
	      // -------------------------------------------------------------------
	      String file1 = "";          // 원본 파일명 image

	      // 전송 파일이 없어도 file1MF 객체가 생성됨.
	      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
	      //           value='' placeholder="파일 선택">
	      MultipartFile mf = articlesVO.getFile1MF();
	          
	      file1 = mf.getOriginalFilename(); // 원본 파일명
	      size1 = mf.getSize();  // 파일 크기
	          
	      if (size1 > 0) { // 폼에서 새롭게 올리는 파일이 있는지 파일 크기로 체크 ★
	        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
	        file1saved = Upload.saveFileSpring(mf, upDir); 
	        
	        if (Tool.isImage(file1saved)) { // 이미지인지 검사
	          // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
	          thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
	        }
	        
	      } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
	        file1="";
	        file1saved="";
	        thumb1="";
	        size1=0;
	      }
	          
	      articlesVO.setFile1(file1);
	      articlesVO.setFile1saved(file1saved);
	      articlesVO.setThumb1(thumb1);
	      articlesVO.setSize1(size1);
	      // -------------------------------------------------------------------
	      // 파일 전송 코드 종료
	      // -------------------------------------------------------------------
	          
	      this.articlesProc.update_file(articlesVO); // Oracle 처리

	      mav.addObject("articlesno", articlesVO.getArticlesno());
	      mav.addObject("topicno", articlesVO.getTopicno());
	      mav.setViewName("redirect:/articles/read.do"); // request -> param으로 접근 전환
	                
	    } else {
	      mav.addObject("url", "/manager/login_need"); // login_need.jsp, redirect parameter 적용
	      mav.setViewName("redirect:/articles/msg.do"); // GET
	    }

	    // redirect하게되면 전부 데이터가 삭제됨으로 mav 객체에 다시 저장
	    mav.addObject("now_page", articlesVO.getNow_page());
	    
	    return mav; // forward
	  }   
	  
	  /**
	   * 파일 삭제 폼
	   * http://localhost:9092/articles/delete.do?articlesno=1
	   * 
	   * @return
	   */
	  @RequestMapping(value = "/articles/delete.do", method = RequestMethod.GET)
	  public ModelAndView delete(HttpSession session, int articlesno) {
	    ModelAndView mav = new ModelAndView();
	    
	    if (managerProc.isManager(session)) { // 관리자로 로그인한경우
	      ArticlesVO articlesVO = this.articlesProc.read(articlesno);
	      mav.addObject("articlesVO", articlesVO);
	      
	      TopicVO topicVO = this.topicProc.read(articlesVO.getTopicno());
	      mav.addObject("topicVO", topicVO);
	      
	      mav.setViewName("/articles/delete"); // /WEB-INF/views/articles/delete.jsp
	      
	    } else {
	      mav.addObject("url", "/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
	      mav.setViewName("redirect:/articles/msg.do"); 
	    }


	    return mav; // forward
	  }
	  
	  /**
	   * 삭제 처리 http://localhost:9092/articles/delete.do
	   * 
	   * @return
	   */
	  @RequestMapping(value = "/articles/delete.do", method = RequestMethod.POST)
	  public ModelAndView delete(ArticlesVO articlesVO) {
	    ModelAndView mav = new ModelAndView();
	    
	    // -------------------------------------------------------------------
	    // 파일 삭제 시작
	    // -------------------------------------------------------------------
	    // 삭제할 파일 정보를 읽어옴.
	    ArticlesVO articlesVO_read = articlesProc.read(articlesVO.getArticlesno());
	        
	    String file1saved = articlesVO.getFile1saved();
	    String thumb1 = articlesVO.getThumb1();
	    
	    String uploadDir = Articles.getUploadDir();
	    Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
	    Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
	    // -------------------------------------------------------------------
	    // 파일 삭제 종료
	    // -------------------------------------------------------------------
	        
	    this.articlesProc.delete(articlesVO.getArticlesno()); // DBMS 삭제
	        
	    // -------------------------------------------------------------------------------------
	    // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
	    // -------------------------------------------------------------------------------------    
	    // 마지막 페이지의 마지막 10번째 레코드를 삭제후
	    // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
	    // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
	    int now_page = articlesVO.getNow_page();
	    
	    HashMap<String, Object> hashMap = new HashMap<String, Object>();
	    hashMap.put("topicno", articlesVO.getTopicno());
	    hashMap.put("word", articlesVO.getWord());
	    
	    if (articlesProc.search_count(hashMap) % Articles.RECORD_PER_PAGE == 0) {
	      now_page = now_page - 1; // 삭제시 DBMS는 바로 적용되나 크롬은 새로고침등의 필요로 단계가 작동 해야함.
	      if (now_page < 1) {
	        now_page = 1; // 시작 페이지
	      }
	    }
	    // -------------------------------------------------------------------------------------

	    mav.addObject("topicno", articlesVO.getTopicno());
	    mav.addObject("now_page", now_page);
	    mav.setViewName("redirect:/articles/list_by_topicno.do"); 
	    
	    return mav;
	  }   
	  
	// http://localhost:9092/articles/delete_by_topicno.do?topicno=1
	  // 파일 삭제 -> 레코드 삭제
	  @RequestMapping(value = "/articles/delete_by_topicno.do", method = RequestMethod.GET)
	  public String delete_by_topicno(int topicno) {
	    ArrayList<ArticlesVO> list = this.articlesProc.list_by_topicno(topicno);
	    
	    for(ArticlesVO articlesVO : list) {
	      // -------------------------------------------------------------------
	      // 파일 삭제 시작
	      // -------------------------------------------------------------------
	      String file1saved = articlesVO.getFile1saved();
	      String thumb1 = articlesVO.getThumb1();
	      
	      String uploadDir = Articles.getUploadDir();
	      Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
	      Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
	      // -------------------------------------------------------------------
	      // 파일 삭제 종료
	      // -------------------------------------------------------------------
	    }
	    
	    int cnt = this.articlesProc.delete_by_topicno(topicno);
	    System.out.println("-> count: " + cnt);
	    
	    return "";
	  
	  }


}
