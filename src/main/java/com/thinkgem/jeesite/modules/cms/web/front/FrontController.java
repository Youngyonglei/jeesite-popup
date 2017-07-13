/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.cms.web.front;

import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;

/**
 * 网站Controller
 * @author ThinkGem
 * @version 2013-5-29
 */
@Controller
@RequestMapping(value = "${frontPath}")
public class FrontController extends BaseController{

	@Autowired
	private SystemService systemService;
	@Autowired
	private UserDao userDao;
	/**
	 * 网站首页
	 */
	@RequestMapping
	public String index(Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		model.addAttribute("isIndex", true);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontIndex";
	}

//	/**
//	 * 验证登录名是否有效
//	 * @param username
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value = "checkLoginName")
//	public String checkLoginName(String username) {
//		User user = new User();
//		user.setLoginName(username);
//		if(userDao.getByLoginName(user)!=null){
//			return "true";
//		}
//		return "false";
//	}

//	/**
//	 * 验证登录名是否有效
//	 * @param username
//	 * @param password
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value = "checkPassword")
//	public String checkPassword(String username,String password) {
//		User user = new User();
//		user.setLoginName(username);
//		User fUser = userDao.getByLoginName(user);
//		if(fUser!=null){
//			if (SystemService.validatePassword(password, fUser.getPassword())){
//				return "true";
//			}else {
//				return "false";
//			}
//		}else {
//			return "false";
//		}
//	}
}
