package dev.mvc.cal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

@Controller
public class CalCont {
	@Autowired
	@Qualifier("dev.mvc.cal.CalProc") // @Component("dev.mvc.cal.CalProc")
	private CalProcInter calProc;

	public CalCont () {
	    System.out.println("-> CalCont created.");
	  }


}
