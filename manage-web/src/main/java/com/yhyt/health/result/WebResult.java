package com.yhyt.health.result;

import com.yhyt.health.constant.ResultCode;

import java.io.Serializable;
import java.util.List;

public class WebResult<T> implements Serializable {

    private static final long serialVersionUID = -4187396720490049366L;
    private String msg;
    private boolean rel = true;
    private List<T> list;
    private String code="200";
    private T entity;

    private ResultCode resultCode;


    public void setResultCode(ResultCode resultCode) {
        this.resultCode = resultCode;
        msg=resultCode.msg();
        code=resultCode.val();
    }

    public T getEntity() {
        return entity;
    }

    public void setEntity(T entity) {
        this.entity = entity;
    }

    private long count;

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public boolean isRel() {
        return rel;
    }

    public void setRel(boolean rel) {
        this.rel = rel;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
