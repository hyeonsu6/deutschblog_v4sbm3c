package dev.mvc.fotorama;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.articles.ArticlesProcInter;
import dev.mvc.articles.ArticlesVO;
import dev.mvc.german.GermanProcInter;
import dev.mvc.topic.TopicProcInter;
import dev.mvc.manager.ManagerProcInter;

@Controller
public class FotoramaCont {
	@Autowired
	@Qualifier("dev.mvc.manager.ManagerProc") // @Component("dev.mvc.manager.ManagerProc")
	private ManagerProcInter managerProc;
	
	@Autowired
	@Qualifier("dev.mvc.german.GermanProc") // @Component("dev.mvc.german.GermanProc")
	private GermanProcInter germanProc;
	
	@Autowired
	@Qualifier("dev.mvc.articles.ArticlesProc") // @Component("dev.mvc.articles.ArticlesProc")
	private ArticlesProcInter articlesProc;


    public FotoramaCont() {
        System.out.println("-> FotoramaCont created.");

    }

    /**
     * Gallery 전체 이미지 출력
     * http://localhost:9092/articles/list_all_gallery.do
     * @return
     */
    @RequestMapping(value="/articles/list_all_gallery.do", method = RequestMethod.GET)
    public ModelAndView list_all_gallery(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      if (this.managerProc.isManager(session) == true) {
        mav.setViewName("/articles/list_all_gallery"); // /WEB-INF/views/articles/list_all_gallery.jsp
        
        ArrayList<ArticlesVO> list = this.articlesProc.list_all();
        mav.addObject("list", list);
        
      } else {
        mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
        
      }
      
      return mav;
    }
    
    /**
     * Gallery 전체 이미지 출력
     * http://localhost:9092/articles/list_all_german_gallery.do
     * @return
     */
    @RequestMapping(value="/articles/list_all_german_gallery.do", method = RequestMethod.GET)
    public ModelAndView list_all_german_gallery(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      if (this.germanProc.isGerman(session) == true) {
        mav.setViewName("/articles/list_all_german_gallery"); // /WEB-INF/views/articles/list_all_gallery.jsp
        
        ArrayList<ArticlesVO> list = this.articlesProc.list_all();
        mav.addObject("list", list);
        
      } else {
        mav.setViewName("/german/login_need"); // /WEB-INF/views/german/login_need.jsp
        
      }
      
      return mav;
    }

}