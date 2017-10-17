package com.numberONe.util;

import lombok.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 用户后台向前台返回的JSON对象
 *
 */
@Data
@AllArgsConstructor
public class CodeMsg {

    //返回状态码
    private int code;

    //提示信息
    private String msg;

    //0表示正常
    public static final int SUCCESS_CODE = 0;

    //1表示失败
    public static final int ERROR_CODE = 1;

    public static final CodeMsg SUCCESS = new CodeMsg(SUCCESS_CODE, "success", null);

    public static final CodeMsg ERROR = new CodeMsg(ERROR_CODE, "error", null);

    private Object obj;

    public CodeMsg(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public boolean isSuccess() {
        return code == SUCCESS_CODE;
    }
}
