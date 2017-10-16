package com.numberONe.util;


import com.numberONe.enums.CustomerType;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by yanghailong on 2017/10/16.
 */
public class TransformUtils {

    public static Map<String, Map<Integer, String>> enumMap = new HashMap<String, Map<Integer, String>>() {
        {
            put("customerType", new HashMap<Integer, String>() {
                {
                    Arrays.asList(CustomerType.values()).forEach(e->put(e.type, e.name()));
                }
            });
        }
    };

    public static List<Map<String, Object>> transformEnum(List<Map<String, Object>> list) {
        return Optional.ofNullable(list).orElse(Collections.emptyList()).stream().map(TransformUtils::transformEnumSingle).collect(Collectors.toList());
    }

    public static Map<String, Object> transformEnumSingle(Map<String, Object> map) {
        if (map == null) {
            return null;
        }
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
            if (enumMap.containsKey(key)) {
                Map<Integer, String> valuesMap = enumMap.get(key);
                String str = valuesMap.get(value);
                if (str != null) {
                    entry.setValue(str);
                } else {
                    entry.setValue("未知");
                }
            }
        }
        return map;
    }

}
