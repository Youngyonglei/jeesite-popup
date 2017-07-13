package com.thinkgem.jeesite.modules.sys.web;

import com.thinkgem.jeesite.common.web.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

/**
 * Created by young on 2017/6/7.
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/voc")
public class VocController extends BaseController{

    @RequestMapping(value = "index")
    public String voc(Model model){
        return "modules/voc/index";
    }
    @RequestMapping(value = "monitor")
    public String monitor(Model model){
        return "modules/voc/monitor";
    }
}
