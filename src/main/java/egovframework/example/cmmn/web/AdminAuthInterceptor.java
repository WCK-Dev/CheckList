package egovframework.example.cmmn.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.example.checklist.service.UserVO;

public class AdminAuthInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
HttpSession session = request.getSession();
		
		Object obj = session.getAttribute("user");
		
		if(obj == null || ((UserVO)obj).getU_id().equals("") ||  !((UserVO)obj).getU_roll().equals("admin")) { 
			response.sendRedirect("/CheckList/checkListMain.do");
			return false;
			
		}
		return true;
	}
}
