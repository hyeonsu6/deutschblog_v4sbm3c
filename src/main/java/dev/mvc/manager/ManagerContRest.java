package dev.mvc.manager;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;


@RestController // REST 컨트롤러 선언
public class ManagerContRest {
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") // "dev.mvc.manager.ManagerProc"라고 명명된 클래스
  private ManagerProcInter managerProc; // ManagerProcInter를 구현한 ManagerProc 클래스의 객체를 자동으로 생성하여 할당

  public ManagerContRest() {
    System.out.println("-> ManagerContRest created.");
  }

  /**
   * Cookie 기반 로그인 처리
   * http://localhost:9091/manager/login_rest.do
   {
     
   }
   * @return
   */
  @PostMapping(path = "/manager/login_rest.do")
  public String login_proc(HttpServletResponse response, HttpSession session, @RequestBody ManagerVO managerVO) {

    JSONObject json = new JSONObject();

    int cnt = managerProc.login(managerVO);
    if (cnt == 1) { // 로그인 성공시 회원 정보 조회
      ManagerVO managerVO_read = managerProc.read_by_id(managerVO.getId()); // DBMS에서 id를 이용한 회원 조회
      session.setAttribute("managerno", managerVO_read.getManagerno()); // 서버의 메모리에 기록
      session.setAttribute("manager_id", managerVO_read.getId());
      session.setAttribute("manager_mname", managerVO_read.getMname());
      session.setAttribute("manager_grade", managerVO_read.getGrade());

      json.put("sw", "true");
      json.put("managerno", managerVO_read.getManagerno());
    } else {
      json.put("sw", "false");
    }

    return json.toString();
  }
  
  /**
   * 로그아웃 처리
   * http://localhost:9091/manager/logout_rest.do 
   * @param session
   * @return
   */
  @GetMapping(path="/manager/logout_rest.do")
  public String logout(HttpSession session){
    
    session.invalidate(); // 모든 session 변수 삭제
    
    JSONObject json = new JSONObject();

    json.put("logout", "true");
         
    return json.toString();
  }
  
}

