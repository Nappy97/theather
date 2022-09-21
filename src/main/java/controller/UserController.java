package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.C;
import service.Service;
import service.user.ApiLoginService;
import service.user.LoginService;
import service.user.RegisterService;

@WebServlet("/user/*")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UserController() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // �븳湲� �씤肄붾뵫
		action(request, response);
	}
	protected void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("\n>> " + getClass().getName() + ".action() 실행");
		
		// URL濡쒕��꽣 URI, ContextPath, Command 遺꾨━
		String uri = request.getRequestURI();   			// --> /JSP18_MVC/board/aaa
		String conPath = request.getContextPath();  		// --> /JSP18_MVC
		String command = uri.substring(conPath.length());  	// --> /board/aaa
		
		// request method
		String method = request.getMethod();   // GET, POST, PUT, PATCH, DELETE ...

		// 留� request 留덈떎 異쒕젰 (�뀒�뒪�듃)
		System.out.println("request: " + uri + " (" + method + ")");  
		System.out.println("conPath: " + conPath);  
		System.out.println("command: " + command);
		
		
		// 而⑦듃濡ㅻ윭�뒗 
		// 1. 而ㅻ㎤�뱶�뿉 �뵲�씪, �빐�떦 Service 濡쒖쭅�쓣 �닔�뻾�쓣 �븯怨�
		// 2. 寃곌낵瑜� �궡蹂대궪 view瑜� 寃곗젙�븳�떎
		Service service = null;	// �뼱�뼚�븳 Service 濡쒖쭅�쓣 �닔�뻾�븷吏�
		String viewPage = null; // �뼱�뼚�븳 �럹�씠吏�(view)瑜� 蹂댁뿬以꾩�
		String redirectUrl = null;
		
		switch(command) {
			case "/user/register":
				switch(method) {
					case "GET":
						C.retrieveRedirectAttribute(request);
						viewPage = "/user/register.jsp";
						break;
					case "POST":
						service = new RegisterService();
						service.execute(request,  response);
		                // redirect 媛� 吏꾪뻾�릺硫� �씠誘� response 媛� commit �맖.
		                // response 媛� commit �릺吏� �븡�� 寃쎌슦留� jsp forward 吏꾪뻾
						if (!response.isCommitted())
							viewPage = "/user/registerOK.jsp";
						break;
				}
				break;
			case "/user/login":
				switch(method) {
					case "GET": // 濡쒓렇�씤 �뤌
						C.retrieveRedirectAttribute(request);
						viewPage = "/user/login.jsp";
						break;
					case "POST": //濡쒓렇�씤 吏꾪뻾
						service = new LoginService();
						service.execute(request, response);
						
						// Redirect媛� �씪�뼱�굹吏� �븡怨� 濡쒓렇�씤 �꽦怨듯뻽�떎硫�
						if (!response.isCommitted()) {
							// 湲곕낯�쟻�쑝濡� home�쑝濡� redirect�븳�떎
							redirectUrl = request.getContextPath() + "/movie/home";
							
							// �샊�떆 url prior媛� 議댁옱�뻽�떎硫� �빐�떦 url濡� redirect
							String urlPrior = C.retrieveUrlPrior(request);
							if (urlPrior != null) redirectUrl = urlPrior;
							
							response.sendRedirect(redirectUrl);
						}
						break;
				}
				break;
			case "/user/logout":
				if (method.equals("POST")) {
					request.getSession().removeAttribute(C.PRINCIPAL);
					response.sendRedirect(request.getContextPath() + "/movie/home");
				}
				break;
			case "/user/rejectAuth":
				viewPage = "/common/rejectAuth.jsp";
				break;
			case "/user/apiLogin":
				service = new ApiLoginService();
				service.execute(request,  response);
				redirectUrl = request.getContextPath() + "/movie/home";
				response.sendRedirect(redirectUrl);
				break;
			case "/user/naverOK":
				viewPage = "/common/naverOK.jsp";
				break;
		}
		
		//�쐞�뿉�꽌 寃곗젙�맂 酉� �럹�씠吏�(viewPage)濡� forward �빐以�
		if (viewPage != null) {
			RequestDispatcher dispatcher = 
				request.getRequestDispatcher("/WEB-INF/views" + viewPage);
			dispatcher.forward(request, response);
		}
	}
}
