package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class UpdateMember
 */
@WebServlet("/updateMember")
public class UpdateMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateMember() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		Member m = new Member();

		m.setMemberPw(request.getParameter("memberPw"));
		m.setAddr(request.getParameter("memberAddress"));
		m.setPhone(request.getParameter("memberPhone"));
		m.setMemberName(request.getParameter("memberName"));
		m.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
		
		// 3.비즈니스 로직
		int result = new MemberService().updateMember(m);
		//
		// 4.결과처리
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");

		if (result == 0) {
			// 회원가입 실패
			request.setAttribute("msg", "정보변경실패!");
			// alert으로 안내 후 이동할 페이지 지정
			// 페이지 이동
		} else {
			// 성공
			request.setAttribute("msg", "정보변경 성공. "
					+ "다시 로그인 해주세요.");
			HttpSession session = request.getSession(false);
			session.invalidate();
		}
		request.setAttribute("loc", "/");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
