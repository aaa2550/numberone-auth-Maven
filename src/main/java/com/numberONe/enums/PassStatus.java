package com.numberONe.enums;

import lombok.AllArgsConstructor;

/**
 * Created by yanghailong on 2017/10/16.
 */

@AllArgsConstructor
public enum PassStatus {

    未审核(0),
    已通过(1),
    未通过(2);

    public int type;

}
