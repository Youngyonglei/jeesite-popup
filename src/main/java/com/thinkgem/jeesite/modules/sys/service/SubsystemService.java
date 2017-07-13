/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.Subsystem;
import com.thinkgem.jeesite.modules.sys.dao.SubsystemDao;

/**
 * 子系统Service
 * @author @Young
 * @version 2017-07-11
 */
@Service
@Transactional(readOnly = true)
public class SubsystemService extends CrudService<SubsystemDao, Subsystem> {

	public Subsystem get(String id) {
		return super.get(id);
	}
	
	public List<Subsystem> findList(Subsystem subsystem) {
		return super.findList(subsystem);
	}
	
	public Page<Subsystem> findPage(Page<Subsystem> page, Subsystem subsystem) {
		return super.findPage(page, subsystem);
	}
	
	@Transactional(readOnly = false)
	public void save(Subsystem subsystem) {
		super.save(subsystem);
	}
	
	@Transactional(readOnly = false)
	public void delete(Subsystem subsystem) {
		super.delete(subsystem);
	}
	
}