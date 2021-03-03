/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.42
 * Generated at: 2019-10-26 07:00:34 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.FTBC_005fLookView;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import vo.ProjectVO;

public final class Category_005fProjectList_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("vo.ProjectVO");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	List<ProjectVO> List = null; 
	ProjectVO p = null;
	String cat = request.getAttribute("cat").toString();
	if(request.getAttribute("projectList")!=null){
		List =	(List<ProjectVO>)request.getAttribute("projectList");

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!--=============================================================================================\r\n");
      out.write("\t카테고리별 프로젝트 리스트\r\n");
      out.write("\t날짜:2019-09-12\r\n");
      out.write("================================================================================================  -->\r\n");
      out.write("\r\n");
      out.write("\t<!--상단 부분  -->\r\n");
      out.write("\t\r\n");
      out.write("\r\n");

				for(int i=0;i<List.size();i++){
					ProjectVO pVO = List.get(i);
				

      out.write("\r\n");
      out.write("\t\t\t\t\t<div class=\"card col-xs-3\" onclick=\"projectDetail('");
      out.print(pVO.getProject_code());
      out.write("')\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"card-header\">\r\n");
      out.write("\t\t\t\t\t\t\t<img src=\"");
      out.print(pVO.getPjo_img());
      out.write("\"class=\"card_img\"> \r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<div class=\"card-body\">\r\n");
      out.write("\t\t\t\t\t\t\t<span class=\"card-text project_title\">");
      out.print(pVO.getPjo_longtitle());
      out.write("</span> \r\n");
      out.write("\t\t\t\t\t\t\t<span class=\"card-text project_nick\">");
      out.print(pVO.getPjo_nickname());
      out.write("</span>\r\n");
      out.write("\t\t\t\t\t\t\t<hr width=");
      out.print((float)((Double.valueOf(pVO.getFundedMoney())/Double.valueOf(pVO.getFd_targetMoney()))*100));
      out.write("%  style=\"max-width: 80%\"  align=\"left\" class=\"card_hr\">\r\n");
      out.write("\t\t\t\t\t\t\t<span class=\"card-text project_date col-xs-5\" ><img id=\"project_img\" src=\"../FTBC_Images/date.png\"/>");
      out.print(pVO.getOutLine() );
      out.write("일 남음</span> \r\n");
      out.write("\t\t\t\t\t\t\t<span class=\"card-text project_cost col-xs-5\">");
      out.print(pVO.getFundedMoney());
      out.write("원</span><span class=\"card-text project_per col-xs-2\">");
      out.print((long)((Double.valueOf(pVO.getFundedMoney())/Double.valueOf(pVO.getFd_targetMoney()))*100));
      out.write("%</span>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");

	}
	}

      out.write("\t\r\n");
      out.write("\t\t");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
