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
import service.srv.DeleteService;
import service.srv.DetailService;
import service.srv.ListService;
import service.srv.SelecetService;
import service.srv.UpdateService;
import service.srv.WriteService;

@WebServlet("/service/*")
public class ServiceController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServiceController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		action(request, response);
	}

	protected void action(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("\n>> " + getClass().getName() + ".action() 호출");

		// URL로부터 URI, ContextPath, Command 분리
		String uri = request.getRequestURI(); // --> /JSP18_MVC/board/aaa
		String conPath = request.getContextPath(); // --> /JSP18_MVC
		String command = uri.substring(conPath.length()); // --> /board/aaa

		// request method
		String method = request.getMethod(); // GET, POST, PUT, PATCH, DELETE ...

		// 매 request 마다 출력 (테스트)
		System.out.println("request: " + uri + " (" + method + ")");
		System.out.println("conPath: " + conPath);
		System.out.println("command: " + command);

		String view = null;
		Service service = null;

		switch (command) {
		// 고객센터
		case "/service/list":
			service = new ListService();
			service.execute(request, response);
			view = "list.jsp";
			break;
		// 문의글 작성
		case "/service/write":
			switch (method) {
			case "GET":
				view = "write.jsp";
				break;
			case "POST":
				service = new WriteService();
				service.execute(request, response);
				view = "writeOK.jsp";
				break;
			}
			break;
		// 문의글 수정
		case "/service/update":
			if (C.securityCheck(request, response, new String[] { "ROLE_MEMBER" })) {
				switch (method) {
				case "GET":
					service = new SelecetService();
					service.execute(request, response);
					
					if(!response.isCommitted()) {
						view = "update.jsp";
					}
					break;
				case "POST":
					service = new UpdateService();
					service.execute(request, response);
					view = "updateOK.jsp";
					break;
				}
			}
			break;
		// 문의글 상세
		case "/service/detail":
			if (C.securityCheck(request, response, null)) {
				service = new DetailService();
				service.execute(request, response);
				view = "detail.jsp";
			}
			break;

		case "/service/delete":
			if (C.securityCheck(request, response, new String[] { "ROLE_MEMBER" })) { // 권한 체크
				switch (method) {
				case "POST":
					service = new DeleteService(); // 작성자가 아닌 경우 Service 안에서 redirect 발생
					service.execute(request, response);
					if (!response.isCommitted()) {
						view = "deleteOK.jsp";
					}
					break;
				}
			}
			break;
			
		case "/service/pageRows":
			int page = Integer.parseInt(request.getParameter("page"));
		    Integer pageRows = Integer.parseInt(request.getParameter("pageRows"));
		    request.getSession().setAttribute("pageRows", pageRows);
			response.sendRedirect(request.getContextPath() + "/service/list?page=" + page);
			break;
			
		}

		// 위에서 결정된 뷰로 forward 함
		if (view != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/service/" + view);
			dispatcher.forward(request, response);
		}

	}

}
