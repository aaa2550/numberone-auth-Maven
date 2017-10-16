package com.numberONe.util;

import com.lbs.trace.common.exception.TransformException;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Created by yanghailong on 2017/10/16.
 */
public class TransformUtils {

    public static <T> List<T> transform(List<Map<String, Object>> list, Class<T> clazz) {
        return Optional.ofNullable(list).orElse(Collections.emptyList()).stream().map(e->transformSingle(e, clazz)).collect(Collectors.toList());
    }

    public static <T> T transformSingle(Map<String, Object> map, Class<T> clazz) {
        if (map == null) {
            return null;
        }
        try {
            T t = clazz.newInstance();
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                Field field = clazz.getField(key);
                Class propertyClazz = field.getType();
                if (propertyClazz.isInstance(value)) {
                    Method method = clazz.getMethod(getSetMethodName(key), propertyClazz);
                    method.invoke(t, value);
                } else {
                    Object propertyObj = propertyClazz.newInstance();
                    Method valueOfMethod = propertyClazz.getMethod("valueOf", String.class);
                    Object stringValue = valueOfMethod.invoke(t, value.toString());
                }
            }
        } catch (InstantiationException | IllegalAccessException | NoSuchMethodException | NoSuchFieldException | InvocationTargetException e) {
            throw new TransformException("类型转换错误, map=" + map + ",clazz=" + clazz.getName() + ",e=" + e.getMessage());
        }
        return null;
    }

    private static String getSetMethodName(String propertyName) {
        return "set" + propertyName.substring(0, 1).toUpperCase() + propertyName.substring(1);
    }

}
