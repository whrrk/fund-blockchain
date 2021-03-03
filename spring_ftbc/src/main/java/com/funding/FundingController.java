package com.funding;


import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.ProjectLogic;

import vo.GiftVO;
import vo.ProjectVO;


@Controller
@RequestMapping("/Funding/*")
public class FundingController {
	private static final Logger logger = LoggerFactory.getLogger(FundingController.class);
	
	@Autowired
	FundingLogic fundingLogic = null;
	
	@GetMapping(value="fundDetail")
	public String getfundproject(@RequestParam String projectCode, Model mod, String mem_email) {
		//프로젝트 상세보기
		logger.info("Controller fundDetail 호출");
		ProjectVO FundingDetail = fundingLogic.getFundDetail(projectCode,mem_email);
		List<Object> FundingGiftDetail = fundingLogic.getFundGiftDetail(projectCode);
		List<GiftVO> sortationSelect=fundingLogic.sortationSelect(FundingGiftDetail);
		List<String> aList = (List<String>) FundingGiftDetail.get(0);
		List<GiftVO> bList = (List<GiftVO>) FundingGiftDetail.get(1);
		mod.addAttribute("sortationSelect",sortationSelect); // sList
		mod.addAttribute("FundingDetail", FundingDetail);  
		mod.addAttribute("FundingGiftDetail",FundingGiftDetail); // gop_list
		return "forward:/FTBC_FundView/Fund_Project.jsp";
	}
	
	@GetMapping(value="payFund")
	public String getPayFund(@RequestParam String gift_code,@RequestParam String pjo_code,@RequestParam String donation,Model mod) {
		ProjectVO payFund = fundingLogic.getPayFund(gift_code,pjo_code);
		mod.addAttribute("payFund",payFund);
		mod.addAttribute("donation",donation);
		return "forward:/FTBC_FundView/Pay_Project.jsp";
	}

}
