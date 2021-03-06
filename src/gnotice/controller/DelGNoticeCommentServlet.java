package gnotice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gnotice.model.service.GNoticeService;

/**
 * Servlet implementation class DelGNoticeCommentServlet
 */
@WebServlet(name = "DelGNoticeComment", urlPatterns = { "/delGNoticeComment" })
public class DelGNoticeCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DelGNoticeCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cmtNo = Integer.parseInt(request.getParameter("cmtNo"));
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		int groupId = Integer.parseInt(request.getParameter("groupId"));
		int mem = Integer.parseInt(request.getParameter("mem"));
		GNoticeService gns = new GNoticeService();
		int result = gns.deleteNoticeCmt(cmtNo);
		if(result > 0) {
			response.sendRedirect("/gNoticeView?groupId=" + groupId + "&noticeNo=" + noticeNo + "&mem=" + mem);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
			request.setAttribute("msg", "댓글 삭제중 에러가 발생했습니다.");
			request.setAttribute("loc", "/gNoticeView?groupId=" + groupId + "&noticeNo=" + noticeNo + "&mem=" + mem);
			rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
