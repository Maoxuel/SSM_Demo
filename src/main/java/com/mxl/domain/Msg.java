package com.mxl.domain;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/*
    通用的返回类
 */
public class Msg {
    //状态码200-成功 400-失败
    private Integer code;
    //提示信息
    private String msg;
    //用户要返回给浏览器的信息
    private Map<String,Object> extend = new HashMap<>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理成功");
        return msg;
    }

    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(400);
        msg.setMsg("处理失败");
        return msg;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public Msg add(String key, Object value) {
        this.getExtend().put(key,value);
        return this;
    }
}
