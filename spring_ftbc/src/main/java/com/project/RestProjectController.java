package com.project;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import vo.ProjectVO;

@RestController
@RequestMapping("/Project")
public class RestProjectController {
	private static final Logger logger = LoggerFactory.getLogger(RestProjectController.class);
	@Autowired
	ProjectLogic projectLogic = null;

	@PostMapping("createProject.ftbc")
	public String CreateProject(@RequestParam Map<String, Object> pMap) throws Exception {
		int result = 0;
		logger.info("rest컨트롤러 도착");
		result = projectLogic.CreateProject(pMap);
		logger.info("123 : " + result);
		if (result == 1) {
			return "redirect:FTBC_myProjectList.jsp";
		} else {
			return "redirect:no";
		}
	}

	@PostMapping("/ManageProjects.ftbc")
	public @ResponseBody Object ManageProjects(@ModelAttribute("projectVO") ProjectVO pVO) {
		logger.info("ManageProjects");
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("data", projectLogic.ManageProjects(pVO));
		Object result = mp;

		return result;
	}
	
	  @GetMapping("/ApproveProject")
	   public String ApporveProject(@RequestParam String projectCode) {
	      logger.info("@@@@@@@@@@@@@ ApporveProject @@@@@@@@@@@@@@@@@@");
	      logger.info("projectCode =================== "  + projectCode);
	      String msg = projectLogic.ApporveProject(projectCode);
	      return msg;
	   }
}