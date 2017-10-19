package build;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * Created by yanghailong on 2017/10/19.
 */
public class Builder {

    public final static String OUT_DIR = "C:\\Users\\sqyc\\Desktop\\test" + File.separator;
    public final static String TEMPLATE_DIR = "C:\\Users\\sqyc\\Desktop\\办公\\open-source\\numberone-auth-Maven\\doc" + File.separator;
    public final static String TEMPLATE_FORM_DIR = OUT_DIR + "form" + File.separator;
    public final static String TEMPLATE_ACTION_DIR = OUT_DIR + "action" + File.separator;
    public final static String TEMPLATE_HTML_DIR = OUT_DIR + "html" + File.separator;
    public final static String FROM_TEMPLATE_NAME = TEMPLATE_DIR + "from.java";
    public final static String LIST_HTML_TEMPLATE_NAME = TEMPLATE_DIR + "list.html";
    public final static String EDIT_HTML_TEMPLATE_NAME = TEMPLATE_DIR + "edit.html";
    public final static String ACTION_TEMPLATE_NAME = TEMPLATE_DIR + "action.java";

    private String sqlContext;
    private List<String> tablesStr;
    private List<SingleTableInfo> singleTableInfos;

    public Builder(String sqlPath) {
        sqlContext = fileToString(sqlPath);
    }

    public Builder build() {
        tablesStr = Arrays.asList(sqlContext.split("DROP"));
        singleTableInfos = tablesStr.stream().map(this::buildSingleTableInfo)
            .filter(Objects::nonNull)
            .collect(Collectors.toList());
        return this;
    }

    public void make() {
        makeForm();
        makeAction();
        makeHtml();
    }

    public void makeHtml() {
        String listTemplateCode = fileToString(LIST_HTML_TEMPLATE_NAME);
        String editTemplateCode = fileToString(EDIT_HTML_TEMPLATE_NAME);
        for (SingleTableInfo singleTableInfo : singleTableInfos) {
            StringBuilder templateCode1 = new StringBuilder();
            StringBuilder templateCode2 = new StringBuilder();
            StringBuilder templateCode3 = new StringBuilder();
            StringBuilder templateCode4 = new StringBuilder();
            for (Property property : singleTableInfo.getProperties()) {
                templateCode1.append("{\n" + "                colkey : \"").append(property.getName()).append("\",\n").append("                name : \"").append(property.getDescription()).append("\"\n").append("            },");
                templateCode2.append("\"").append(singleTableInfo.getHumpName()).append("FormMap.").append(property.getName()).append("\" : {\n").append("                        required : true\n").append("                    },\n");
                templateCode3.append("\"").append(singleTableInfo.getHumpName()).append("FormMap.").append(property.getName()).append("\" : {\n").append("                        required : \"").append(property.getDescription()).append("不能为空\"").append("                    },\n");
                templateCode4.append("<div class=\"form-group\">\n" + "                <label class=\"col-sm-3 control-label\">").append(property.getDescription()).append("</label>\n").append("                <div class=\"col-sm-9\">\n").append("                    <input type=\"text\" class=\"form-control checkacc\"\n").append("                           placeholder=\"").append(property.getDescription()).append("\" value=\"${").append(singleTableInfo.getHumpName()).append(".").append(property.getName()).append("}\" name=\"").append(singleTableInfo.getHumpName()).append("FormMap.").append(property.getName()).append("\"\n").append("                           id=\"").append(property.getName()).append("\">\n").append("                </div>\n").append("            </div>\n").append("            <div class=\"line line-dashed line-lg pull-in\"></div>\n");
            }

            String listStr = listTemplateCode.replace("@[templateCode1]", templateCode1.deleteCharAt(templateCode1.length() - 1));
            listStr = listStr.replace("@[templateCode2]", singleTableInfo.getStartName());
            listStr = listStr.replace("@[templateCode3]", singleTableInfo.getHumpName());
            String editStr = editTemplateCode.replace("@[templateCode1]", templateCode2.delete(templateCode2.length() - 3, templateCode2.length()));
            editStr = editStr.replace("@[templateCode2]", templateCode3.delete(templateCode3.length() - 3, templateCode3.length()));
            editStr = editStr.replace("@[templateCode3]", templateCode4.delete(templateCode4.length() - 2, templateCode4.length()));
            editStr = editStr.replace("@[templateCode4]", singleTableInfo.getStartName());
            editStr = editStr.replace("@[templateCode5]", singleTableInfo.getHumpName());
            String listFileName = TEMPLATE_HTML_DIR + singleTableInfo.getHumpName() + File.separator + "list.jsp";
            String editFileName = TEMPLATE_HTML_DIR + singleTableInfo.getHumpName() + File.separator + "edit.jsp";
            stringToFile(listFileName, listStr);
            stringToFile(editFileName, editStr);
        }
    }

    public void makeForm() {
        String templateCode = fileToString(FROM_TEMPLATE_NAME);
        for (SingleTableInfo singleTableInfo : singleTableInfos) {
            String str = templateCode.replace("@[templateCode1]", singleTableInfo.getTableName());
            str = str.replace("@[templateCode2]", singleTableInfo.bigHumpName());
            String fileName = TEMPLATE_FORM_DIR + singleTableInfo.bigHumpName() + "FormMap";
            stringToFile(fileName, str);
        }
    }

    public void makeAction() {
        String templateCode = fileToString(ACTION_TEMPLATE_NAME);
        for (SingleTableInfo singleTableInfo : singleTableInfos) {
            String str = templateCode.replace("@[templateCode1]", singleTableInfo.getHumpName());
            str = str.replace("@[templateCode2]", singleTableInfo.bigHumpName());
            str = str.replace("@[templateCode3]", singleTableInfo.getStartName());
            String fileName = TEMPLATE_ACTION_DIR  + singleTableInfo.bigHumpName() + "Controller";
            stringToFile(fileName, str);
        }
    }

    public void makeFile(String path) {
        File file = new File(path);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void stringToFile(String path, String content) {
        makeFile(path);
        try (FileOutputStream fileOutputStream = new FileOutputStream(path);
             OutputStreamWriter outputStreamWriter = new OutputStreamWriter(fileOutputStream);
             BufferedWriter bufferedWriter = new BufferedWriter(outputStreamWriter)) {
             bufferedWriter.write(content);
             bufferedWriter.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String fileToString(String path) {
        try (FileInputStream fileInputStream = new FileInputStream(path);
             InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream);
             BufferedReader bufferedReader = new BufferedReader(inputStreamReader)) {
            String lineStr;
            StringBuilder stringBuilder = new StringBuilder();
            while ((lineStr = bufferedReader.readLine()) != null) {
                stringBuilder.append(lineStr + "\n");
            }
            return stringBuilder.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public SingleTableInfo buildSingleTableInfo(String tableStr) {
        if (!tableStr.contains("EXISTS")) {
            return null;
        }
        String tableName = tableStr.substring(tableStr.indexOf("EXISTS `") + 8, tableStr.indexOf("`", tableStr.indexOf("EXISTS `") + 9));
        List<Property> properties = new ArrayList<>();
        String humpName = humpName(tableName);
        String startName = tableName.contains("_") ? tableName.substring(0, tableName.indexOf("_")) : tableName;
        String[] propertiesStr = tableStr.split("\n");
        for (int i = 0; i < propertiesStr.length; i++) {
            if (propertiesStr[i].trim().startsWith("`")) {
                String name = propertiesStr[i].trim().substring(1, propertiesStr[i].trim().lastIndexOf("`"));
                String description = propertiesStr[i].substring(propertiesStr[i].lastIndexOf("--") + 2).trim();
                properties.add(new Property(name, description));
            }
        }
        return new SingleTableInfo(startName, tableName, humpName, properties);
    }

    public String humpName(String tableName) {
        String newTableName = tableName;
        while (newTableName.contains("_")) {
            int index = newTableName.indexOf("_");
            newTableName = newTableName.substring(0, index) + newTableName.substring(index + 1, index + 2).toUpperCase() + newTableName.substring(index + 2);
        }
        return newTableName;
    }

    @AllArgsConstructor
    @Data
    class SingleTableInfo {
        private String startName;
        private String tableName;
        private String humpName;
        private List<Property> properties;
        public String bigHumpName() {
            return humpName.substring(0, 1).toUpperCase() + humpName.substring(1);
        }
    }

    @AllArgsConstructor
    @Data
    class Property {
        private String name;
        private String description;
    }

    public static void main(String[] args) {
        new Builder("C:\\Users\\sqyc\\Desktop\\办公\\open-source\\numberone-auth-Maven\\doc\\db.sql")
            .build()
            .make();
    }

}
