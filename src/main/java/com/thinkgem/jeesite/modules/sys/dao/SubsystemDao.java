/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Subsystem;

import java.util.List;

/**
 * 采集器DAO接口
 * @author @ninth
 * @version 2017-06-30
 */
@MyBatisDao
public interface SubsystemDao extends CrudDao<Subsystem> {
}