/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 采集器Entity
 * @author @ninth
 * @version 2017-06-30
 */
public class Subsystem extends DataEntity<Subsystem> {

	private static final long serialVersionUID = 1L;

	private String name;

	public Subsystem() {
		super();
	}

	public Subsystem(String id){
		super(id);
	}

	public String getName(){
		return name;
	}
	public Subsystem setName(String subsys){
		this.name = subsys;
		return this;
	}
}