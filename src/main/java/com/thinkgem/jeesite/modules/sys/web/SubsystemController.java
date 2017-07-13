/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Subsystem;
import com.thinkgem.jeesite.modules.sys.service.SubsystemService;

import java.util.List;

/**
 * 子系统Controller
 * @author @Young
 * @version 2017-07-11
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/subsystem")
public class SubsystemController extends BaseController {

	@Autowired
	private SubsystemService subsystemService;
	
	@ModelAttribute
	public Subsystem get(@RequestParam(required=false) String id) {
		Subsystem entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = subsystemService.get(id);
		}
		if (entity == null){
			entity = new Subsystem();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:subsystem:view")
	@RequestMapping(value = {"list", ""})
	public String list(Subsystem subsystem, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Subsystem> page = subsystemService.findPage(new Page<Subsystem>(request, response), subsystem); 
		model.addAttribute("page", page);
		return "modules/sys/subsystemList";
	}

	@RequiresPermissions("sys:subsystem:view")
	@RequestMapping(value = "form")
	public String form(Subsystem subsystem, Model model) {
		model.addAttribute("subsystem", subsystem);
		return "modules/sys/subsystemForm";
	}

	@ResponseBody
	@RequiresPermissions("sys:subsystem:edit")
	@RequestMapping(value = "save")
	public String save(Subsystem subsystem, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, subsystem)){
			return form(subsystem, model);
		}
		subsystemService.save(subsystem);
		return "true";
	}
	
	@RequiresPermissions("sys:subsystem:delete")
	@RequestMapping(value = "delete")
	public String delete(Subsystem subsystem, RedirectAttributes redirectAttributes) {
		subsystemService.delete(subsystem);
		addMessage(redirectAttributes, "删除子系统成功");
		return "redirect:"+Global.getAdminPath()+"/sys/subsystem/?repage";
	}

	@ResponseBody
	@RequiresPermissions("user")
	@RequestMapping(value = "getSystemList")
	public List<Subsystem> getSystemList(){
		return subsystemService.findList(new Subsystem());
	}

}