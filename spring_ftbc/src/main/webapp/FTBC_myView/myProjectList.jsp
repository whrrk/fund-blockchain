<%@page import="vo.ProjectVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	List<ProjectVO> pList = (List<ProjectVO>)request.getAttribute("myProjects");
%>

<%
								for(int i=0;i<pList.size();i++){
					ProjectVO pVO = pList.get(i);
					
%>
					<div class="card col-xs-3" onclick="projectDetail('<%=pVO.getProject_code()%>')">
						<div class="card-header">
							<img src="<%=pVO.getPjo_img()%>"class="card_img"> 
						</div>
						<div class="card-body">
							<span class="card-text project_title"><%=pVO.getPjo_longtitle()%></span> 
							<span class="card-text project_nick"><%=pVO.getPjo_nickname()%></span>
							<hr  style="max-width: 80%"  width=<%=(float)((Double.valueOf(pVO.getFundedMoney())/Double.valueOf(pVO.getFd_targetMoney()))*100)%>% align="left" class="card_hr">
							<span class="card-text project_date col-xs-5"><img id="project_img" src="../FTBC_Images/date.png"/><%=pVO.getOutLine() %>일 남음</span> 
							<span class="card-text project_cost col-xs-5"><%=pVO.getFundedMoney()%>원</span><span class="card-text project_per col-xs-2"><%=(long)((Double.valueOf(pVO.getFundedMoney())/Double.valueOf(pVO.getFd_targetMoney()))*100)%>%</span>
						</div>
					</div>
<%
}
%>