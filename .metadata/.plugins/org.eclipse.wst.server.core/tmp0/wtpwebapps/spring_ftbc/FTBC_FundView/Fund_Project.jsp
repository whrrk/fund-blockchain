<%@page import="vo.ProjectVO"%>
<%@page import="vo.GiftVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String pjo_code = null;
	if (request.getParameter("pjo_code") != null) {
		pjo_code = request.getParameter("pjo_code").toString();
	}

	ProjectVO pVO = null;
	if (request.getAttribute("FundingDetail") != null) {
		pVO = (ProjectVO) request.getAttribute("FundingDetail");
	}
	String mem_email = null;
	if (session.getAttribute("mem_email") != null) {
		mem_email = session.getAttribute("mem_email").toString();
	}
	List<Object> rVO = null;
	List<String> gift_code = null;
	List<GiftVO> gop_option = null;
	String payDate = null;
	String giftcode = null;
	int num = 0;
	if (request.getAttribute("FundingGiftDetail") != null) {
		rVO = (List<Object>) request.getAttribute("FundingGiftDetail");
		gift_code = (List<String>) rVO.get(0);
		gop_option = (List<GiftVO>) rVO.get(1);
		payDate = pVO.getFd_deadLine().replaceFirst("-", "년 ");
		payDate = payDate.replaceFirst("-", "월 ");
		payDate = payDate.concat("일"); 
		rVO.get(num);
	}
	String project_code = pVO.getProject_code();
	int project_code_length = project_code.length();
	project_code = project_code.substring(0,project_code_length-1);
	%>
	<!-- 10-23 정원형 funding_project페이지에 선물상세옵션 추가 -->
	<%
	List<GiftVO> sList =null;
	if(request.getAttribute("sortationSelect")!=null){
		sList =(List<GiftVO>)request.getAttribute("sortationSelect");
	}
	
	%>
<html>
<head>
<meta charset="UTF-8">
<title>FTBC</title>
<!--=============================================================================================
	펀딩 페이지
	얼마짜리 펀딩할건지 선택 하는 페이지
	날짜:2019-09-20
================================================================================================  -->
<%@ include file="../FTBC_Common/FTBC_Common.jsp"%>
<link rel="stylesheet" type="text/css"
	href="../FTBC_FundView/Fund_Project.css?8">
</head>
<body>
	<script type="text/javascript">
		function pay(id,gift_num) {
			var donation = $("#"+id).val();
			if(gift_num==0){
				location.href = '/Funding/payFund?gift_code=0&pjo_code=<%=pVO.getProject_code()%>&donation='+donation+'';
			}else{
				location.href = '/Funding/payFund?gift_code='+gift_num+'&pjo_code=<%=pVO.getProject_code()%>&donation='+donation+'';	
			}
		}
		function fundThis(id) {
			$(".Fund_Panel").show();
			$("#" + id).hide();
			$(".Fund_Panel_Reward").hide();
			$("#" + id + "_reward").show();
		}

		/*숫자키 누르고 다른거 눌러야 적용됨.  */
		function valueCheck(value, num) {
			var fundval = Number($("#reward_val" + num).text().replace(",", "")); //리워드 가격
			var pvalue = Number(value.replace(",", ""));
			console.log("fundval: " + fundval);
			if (fundval > pvalue) { //입력한 값이 리워드 가격보다  작을경우
				console.log("@" + fundval + " : " + pvalue + "@");
				$("#reward_notice" + num).text("최소 " + fundval + "원 이상 입력해주세요")
				$("#reward_notice" + num).css("color", "#FF0000");
			} else {
				$("#reward_notice" + num).text("더 많이 입력하실 수 있습니다")
				$("#reward_notice" + num).css("color", "#4B82F0");
			}
		}

		function valStop() {
			event.stopPropagation();
		}

		$(document).ready(function() {
			$(".Fund_Panel_Reward").hide();

		});
	</script>
	<div id="Fund_ajax">
		<div id="FundTop_bar">
			<span id="Fund_title"><%=pVO.getPjo_longtitle()%></span>
		</div>
		<div class="container-fluid">

			<!--================================================================================================================
	 												[  	  내용	]
	 ================================================================================================================-->
			<%
				int giftnum = 0;
			%>
			<!--------------- 0번  상품----------------->
			<div class="row Fund_Panel" id="fund_default<%=giftnum%>"
				onclick="fundThis(id)">
				<div class="Fund_Header">
					<span id="reward_val<%=giftnum%>">1,000</span><span>원 이상
						밀어주시는 분께</span>
				</div>
				<div class="Fund_Body">
					<span>선물을 선택하지 않고, 밀어만 줍니다</span>
				</div>
			</div>

			<!--------------- 0번  상품 리워드----------------->
			<div class="row Fund_Panel_Reward"
				id="fund_default<%=giftnum%>_reward">
				<div class="Fund_Header">
					<input type="text" class="fund_valbox" value="1,000" id="gift_reward<%=giftnum %>"
						onkeyup="valueCheck(value,'<%=giftnum%>')" onclick="valStop()"><span>원</span>
					<a onclick="javascript:pay('gift_reward<%=giftnum %>','<%=giftnum%>')"><img
						src="../FTBC_Images/fundbtn.png"></a>
				</div>
				<div class="Fund_Body">
					<span class="reward_notice" id="reward_notice<%=giftnum%>">더
						많이 입력하실 수 있습니다</span> <br>
					<span>선물을 선택하지 않고, 밀어만 줍니다</span>
				</div>
			</div>

			<%
				for (int i = 0; i < gift_code.size(); i++) {
					giftnum++;
					GiftVO gVO = null;
					for (int k = 0; k < gop_option.size(); k++) {
						if (gift_code.get(i).equals(gop_option.get(k).getGIFT_CODE())) {
							gVO = gop_option.get(k);
							break;
						}
					}
					 if (gVO.GIFT_LIMITED != null) {
                  	  if((Integer.parseInt(gVO.GIFT_LIMITED.toString())) - gVO.getSupport_num()>0){
			%>
			<!--------------- 한정 수량인데 아직 수량이 남았을 경우----------------->
			<div class="row Fund_Panel" id="fund_default<%=giftnum%>"
				onclick="fundThis(id)">
				<div class="Fund_Header">
					<span id="reward_val<%=giftnum%>"><%=gVO.getGIFT_UNITMONEY()%></span><span>원
						이상 밀어주시는 분께</span>
				</div>
				<div class="Fund_Body">
					<%
					String gift_explanation = "";
					if(gVO.getGIFT_EXPLANATION() ==null) {
						gift_explanation = "";
					} else {
						gift_explanation = gVO.getGIFT_EXPLANATION();
					}
					%>
					<span><%=gift_explanation%></span>
					<ul>
						<%
							for (int j = 0; j < gop_option.size(); j++) {
									if (gop_option.get(j).getGIFT_CODE().equals(gift_code.get(i))) {
										GiftVO kVO = gop_option.get(j);
						%>
						<li><%=kVO.getGOP_OPTION()%> (x <%=kVO.getGOP_AMMOUNT()%>)</li>
							<%int cnt = 0;
								for(int k=0;k<sList.size();k++){ 
								if(sList.get(k).getGOP_CODE().equals(kVO.getGOP_CODE())){
									if(sList.get(k).getGOD_SORTATION()==0){}
									else if(sList.get(k).getGOD_SORTATION()==1){
										
										if(cnt==0){
											for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<select class="optionSelect">
										
										<%for(int h=0;h<sList.size();h++){
											if(sList.get(h).getGOP_CODE().equals(kVO.getGOP_CODE())&&sList.get(h).getGOD_SORTATION()==1){
												%>
												<option><%=sList.get(h).getGOD_DESCRIPTION() %></option>												
												<%
											}
										} %>
										</select>
										<br>
									<%  } cnt++;}
									}else if(sList.get(k).getGOD_SORTATION()==2){
										for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<input type="text" class="optionJugwan" placeholder="<%=sList.get(k).getGOD_DESCRIPTION() %>">
										<br>
									<% 	
										}
									}
								}
							%>
						<% 
						}
							}
								}
						%>
					</ul>
				</div>
				<div class="Fund_Footer">
					<span class="Footer_num"><%=gVO.getSupport_num()%></span><span>명이
						선택하였습니다</span> <br>
					<span>예상 전달일:<%=gVO.getGIFT_DELIVERYDATE()%></span>
				</div>
			</div>

			<!--------------- 한정 수량인데 아직 수량이 남았을 경우 리워드----------------->
			<div class="row Fund_Panel_Reward"
				id="fund_default<%=giftnum%>_reward">
				<div class="Fund_Header">
					<input type="text" class="fund_valbox" id="gift_reward<%=giftnum %>"
						value="<%=gVO.getGIFT_UNITMONEY()%>"
						onkeyup="valueCheck(value,'<%=giftnum%>')" onchange="valStop()"><span>원</span>
					<a onclick="javascript:pay('gift_reward<%=giftnum %>','<%=gVO.getGIFT_CODE()%>')"><img
						src="../FTBC_Images/fundbtn.png"></a>
				</div>
				<div class="Fund_Body">
					<span class="reward_notice" id="reward_notice<%=giftnum%>">더
						많이 입력하실 수 있습니다</span> <br>
					<span><%=gVO.getGIFT_EXPLANATION()%></span>
					<ul>
						<%  
						for (int j = 0; j < gop_option.size(); j++) {
									if (gop_option.get(j).getGIFT_CODE().equals(gift_code.get(i))) {
										GiftVO kVO = gop_option.get(j);
						%>
						<li><%=kVO.getGOP_OPTION()%> (x <%=kVO.getGOP_AMMOUNT()%>)</li>
							<%int cnt = 0;
								for(int k=0;k<sList.size();k++){ 
								if(sList.get(k).getGOP_CODE().equals(kVO.getGOP_CODE())){
									
									if(sList.get(k).getGOD_SORTATION()==0){}
									else if(sList.get(k).getGOD_SORTATION()==1){
										
										if(cnt==0){
											for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<select class="optionSelect">
										<%for(int h=0;h<sList.size();h++){
											if(sList.get(h).getGOP_CODE().equals(kVO.getGOP_CODE())&&sList.get(h).getGOD_SORTATION()==1){
												%>
												<option><%=sList.get(h).getGOD_DESCRIPTION() %></option>												
												<%
											}
										} %>
										</select>
										<br>
									<%  } cnt++;}
									}else if(sList.get(k).getGOD_SORTATION()==2){
										for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<input type="text" class="optionJugwan" placeholder="<%=sList.get(k).getGOD_DESCRIPTION() %>">
										<br>
									<% 	
										}
									}
								}
							%>
						<% 
						}
							}
								}
						%>
					</ul>
				</div>
				<div class="Fund_Footer">
					<span class="Footer_num"><%=gVO.getSupport_num()%></span><span>명이
						선택하였습니다</span> <br>
					<span>예상 전달일:<%=gVO.getGIFT_DELIVERYDATE() %></span>
				</div>
			</div>
			<%}else{
				%>
		<!---------------------------------------- 한정수량인데 선착순 마감됐을경우.------------------------------>
			<div class="row Fund_Panel_magam" id="fund_default<%=giftnum%>">
				<div class="Fund_Header" style="opacity:0.4;">
					<span id="reward_val<%=giftnum%>"><%=gVO.getGIFT_UNITMONEY()%></span><span>원
						이상 밀어주시는 분께</span>
				</div>
				<div class="Fund_Body" style="opacity:0.4;">
					<%
					String gift_explanation = "";
					if(gVO.getGIFT_EXPLANATION() ==null) {
						gift_explanation = "";
					} else {
						gift_explanation = gVO.getGIFT_EXPLANATION();
					}
					%>
					<span><%=gift_explanation%></span>
					<ul>
						<%
							for (int j = 0; j < gop_option.size(); j++) {
									if (gop_option.get(j).getGIFT_CODE().equals(gift_code.get(i))) {
										GiftVO kVO = gop_option.get(j);
						%>
						<li><%=kVO.getGOP_OPTION()%> (x <%=kVO.getGOP_AMMOUNT()%>)</li>
							<%int cnt = 0;
								for(int k=0;k<sList.size();k++){ 
								if(sList.get(k).getGOP_CODE().equals(kVO.getGOP_CODE())){
									if(sList.get(k).getGOD_SORTATION()==0){}
									else if(sList.get(k).getGOD_SORTATION()==1){
										
										if(cnt==0){
											for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<select class="optionSelect" >
										
										<%for(int h=0;h<sList.size();h++){
											if(sList.get(h).getGOP_CODE().equals(kVO.getGOP_CODE())&&sList.get(h).getGOD_SORTATION()==1){
												%>
												<option><%=sList.get(h).getGOD_DESCRIPTION() %></option>												
												<%
											}
										} %>
										</select>
										<br>
									<%  } cnt++;}
									}else if(sList.get(k).getGOD_SORTATION()==2){
										for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<input type="text" class="optionJugwan" placeholder="<%=sList.get(k).getGOD_DESCRIPTION() %>">
										<br>
									<% 	
										}
									}
								}
							%>
						<% 
						}
							}
								}
						%>
					</ul>
				</div>
				<div class="Fund_Footer">
					<span class="Footer_num" style="opacity:0.4;"><%=gVO.getSupport_num()%></span><span style="opacity:0.4;">명이
						선택하였습니다</span> <br>
					<span style="opacity:0.4;" >예상 전달일:<%=gVO.getGIFT_DELIVERYDATE()%></span><span style="color:red;"><b>&nbsp;&nbsp;&nbsp;선착순 마감 됨!</b></span>
				</div>
			</div>
				<%
			}
                  	  }else{
                  		  %>
           			<!---------------한정 수량이 아닐 경우----------------->
			<div class="row Fund_Panel" id="fund_default<%=giftnum%>"
				onclick="fundThis(id)">
				<div class="Fund_Header">
					<span id="reward_val<%=giftnum%>"><%=gVO.getGIFT_UNITMONEY()%></span><span>원
						이상 밀어주시는 분께</span>
				</div>
				<div class="Fund_Body">
					<%
					String gift_explanation = "";
					if(gVO.getGIFT_EXPLANATION() ==null) {
						gift_explanation = "";
					} else {
						gift_explanation = gVO.getGIFT_EXPLANATION();
					}
					%>
					<span><%=gift_explanation%></span>
					<ul>
						<%
							for (int j = 0; j < gop_option.size(); j++) {
									if (gop_option.get(j).getGIFT_CODE().equals(gift_code.get(i))) {
										GiftVO kVO = gop_option.get(j);
						%>
						<li><%=kVO.getGOP_OPTION()%> (x <%=kVO.getGOP_AMMOUNT()%>)</li>
							<%int cnt = 0;
								for(int k=0;k<sList.size();k++){ 
								if(sList.get(k).getGOP_CODE().equals(kVO.getGOP_CODE())){
									if(sList.get(k).getGOD_SORTATION()==0){}
									else if(sList.get(k).getGOD_SORTATION()==1){
										
										if(cnt==0){
											for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<select class="optionSelect">
										
										<%for(int h=0;h<sList.size();h++){
											if(sList.get(h).getGOP_CODE().equals(kVO.getGOP_CODE())&&sList.get(h).getGOD_SORTATION()==1){
												%>
												<option><%=sList.get(h).getGOD_DESCRIPTION() %></option>												
												<%
											}
										} %>
										</select>
										<br>
									<%  } cnt++;}
									}else if(sList.get(k).getGOD_SORTATION()==2){
										for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<input type="text" class="optionJugwan" placeholder="<%=sList.get(k).getGOD_DESCRIPTION() %>">
										<br>
									<% 	
										}
									}
								}
							%>
						<% 
						}
							}
								}
						%>
					</ul>
				</div>
				<div class="Fund_Footer">
					<span class="Footer_num"><%=gVO.getSupport_num()%></span><span>명이
						선택하였습니다</span> <br>
					<span>예상 전달일:<%=gVO.getGIFT_DELIVERYDATE()%></span>
				</div>
			</div>

			<!--------------- 한정 수량이 아닐 경우 리워드----------------->
			<div class="row Fund_Panel_Reward"
				id="fund_default<%=giftnum%>_reward">
				<div class="Fund_Header">
					<input type="text" class="fund_valbox" id="gift_reward<%=giftnum %>"
						value="<%=gVO.getGIFT_UNITMONEY()%>"
						onkeyup="valueCheck(value,'<%=giftnum%>')" onchange="valStop()"><span>원</span>
					<a onclick="javascript:pay('gift_reward<%=giftnum %>','<%=gVO.getGIFT_CODE()%>')"><img
						src="../FTBC_Images/fundbtn.png"></a>
				</div>
				<div class="Fund_Body">
					<span class="reward_notice" id="reward_notice<%=giftnum%>">더
						많이 입력하실 수 있습니다</span> <br>
					<span><%=gVO.getGIFT_EXPLANATION()%></span>
					<ul>
						<%  
						for (int j = 0; j < gop_option.size(); j++) {
									if (gop_option.get(j).getGIFT_CODE().equals(gift_code.get(i))) {
										GiftVO kVO = gop_option.get(j);
						%>
						<li><%=kVO.getGOP_OPTION()%> (x <%=kVO.getGOP_AMMOUNT()%>)</li>
							<%int cnt = 0;
								for(int k=0;k<sList.size();k++){ 
								if(sList.get(k).getGOP_CODE().equals(kVO.getGOP_CODE())){
									
									if(sList.get(k).getGOD_SORTATION()==0){}
									else if(sList.get(k).getGOD_SORTATION()==1){
										
										if(cnt==0){
											for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<select class="optionSelect">
										<%for(int h=0;h<sList.size();h++){
											if(sList.get(h).getGOP_CODE().equals(kVO.getGOP_CODE())&&sList.get(h).getGOD_SORTATION()==1){
												%>
												<option><%=sList.get(h).getGOD_DESCRIPTION() %></option>												
												<%
											}
										} %>
										</select>
										<br>
									<%  } cnt++;}
									}else if(sList.get(k).getGOD_SORTATION()==2){
										for(int r=0;r<kVO.getGOP_AMMOUNT();r++){
									%>
										<input type="text" class="optionJugwan" placeholder="<%=sList.get(k).getGOD_DESCRIPTION() %>">
										<br>
									<% 	
										}
									}
								}
							%>
						<% 
						}
							}
								}
						%>
					</ul>
				</div>
				<div class="Fund_Footer">
					<span class="Footer_num"><%=gVO.getSupport_num()%></span><span>명이
						선택하였습니다</span> <br>
					<span>예상 전달일:<%=gVO.getGIFT_DELIVERYDATE() %></span>
				</div>
			</div>       		  
                  		  <%
                  	  }
					}
				%>
		</div>
	</div>
</body>
</html>