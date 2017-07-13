package com.thinkgem.jeesite.modules.sys.web;

import com.thinkgem.jeesite.common.web.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by young on 2017/6/9.
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/video")
public class VideoController extends BaseController{

    @RequestMapping(value = "index")
    public String voc(Model model){
        return "modules/video/index";
    }
}
