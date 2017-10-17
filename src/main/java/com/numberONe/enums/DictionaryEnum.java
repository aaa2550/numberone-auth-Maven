package com.numberONe.enums;

import lombok.AllArgsConstructor;

/**
 * Created by yanghailong on 2017/10/17.
 */
@AllArgsConstructor
public enum DictionaryEnum {

    业务类型(1),
    平台类型(2),
    功能类型(3);

    public int type;

}
