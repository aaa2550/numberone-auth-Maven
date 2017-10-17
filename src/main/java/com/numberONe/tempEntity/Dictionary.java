package com.numberONe.tempEntity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Dictionary {
    private Integer id;

    private Integer businessType;

    private Integer businessTypeIndex;

    private String businessTypeName;

    public Dictionary(Integer businessType, Integer businessTypeIndex) {
        this.businessType = businessType;
        this.businessTypeIndex = businessTypeIndex;
    }

}