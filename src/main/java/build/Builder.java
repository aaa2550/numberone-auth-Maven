package build;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * Created by yanghailong on 2017/10/19.
 */
public class Builder {

    public final static String TEMPLATE_DIR = "from.java" + File.pathSeparator;
    public final static String TEMPLATE_FORM_DIR = TEMPLATE_DIR + "form" + File.pathSeparator;
    public final static String TEMPLATE_ACTION_DIR = TEMPLATE_DIR + "action" + File.pathSeparator;
    public final static String TEMPLATE_HTML_DIR = TEMPLATE_DIR + "html" + File.pathSeparator;
    public final static String FROM_TEMPLATE_NAME = TEMPLATE_DIR + "from.java";
    public final static String LIST_HTML_TEMPLATE_NAME = TEMPLATE_DIR + "list.html";
    public final static String EDIT_HTML_TEMPLATE_NAME = TEMPLATE_DIR + "edit.html";
    public final static String ACTION_TEMPLATE_NAME = TEMPLATE_DIR + "action.java";

    private String sqlContext;
    private List<String> tablesStr;
    private List<SingleTableInfo> singleTableInfos;
    private String outHtmlDir;
    private String outActionDir;
    private String outFromDir;

    public Builder(String outHtmlDir, String outActionDir, String outFromDir, String sqlPath) {
        this.outHtmlDir = outHtmlDir;
        this.outActionDir = outActionDir;
        this.outFromDir = outFromDir;
        sqlContext = fileToString(sqlPath);
    }

    public void build() {
        tablesStr = Arrays.asList(sqlContext.split("DROP"));
        singleTableInfos = tablesStr.stream().map(this::buildSingleTableInfo).collect(Collectors.toList());
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
                templateCode1.append("{\n" +
                        "                colkey : \""+property.getName()+"\",\n" +
                        "                name : \""+property.getDescription()+"\",\n" +
                        "            },");
                templateCode2.append("\""+singleTableInfo.getHumpName()+"FormMap."+property.getName()+"\" : {\n" +
                        "                        required : true\n" +
                        "                    },\n");
                templateCode3.append("\""+singleTableInfo.getHumpName()+"FormMap."+property.getName()+"\" : {\n" +
                        "                        required : \""+property.getDescription()+"不能为空\"" +
                        "                    },\n");
                templateCode4.append("<div class=\"form-group\">\n" +
                        "                <label class=\"col-sm-3 control-label\">"+property.getDescription()+"</label>\n" +
                        "                <div class=\"col-sm-9\">\n" +
                        "                    <input type=\"text\" class=\"form-control checkacc\"\n" +
                        "                           placeholder=\""+property.getDescription()+"\" value=\"${"+singleTableInfo.getHumpName()+"."+property.getName()+"}\" name=\""+singleTableInfo.getHumpName()+"FormMap."+property.getName()+"\"\n" +
                        "                           id=\""+property.getName()+"\">\n" +
                        "                </div>\n" +
                        "            </div>\n" +
                        "            <div class=\"line line-dashed line-lg pull-in\"></div>\n");

            }

            String listStr = listTemplateCode.replace("${templateCode1}", templateCode1.deleteCharAt(templateCode1.length() - 1));
            listStr = listStr.replace("${templateCode2}", singleTableInfo.getStartName());
            listStr = listStr.replace("${templateCode3}", singleTableInfo.getHumpName());
            String editStr = editTemplateCode.replace("${templateCode1}", templateCode2.delete(templateCode1.length() - 3, templateCode2.length()));
            editStr = editStr.replace("${templateCode2}", templateCode3.delete(templateCode1.length() - 3, templateCode3.length()));
            editStr = editStr.replace("${templateCode3}", templateCode2.delete(templateCode1.length() - 2, templateCode2.length()));
            editStr = editStr.replace("${templateCode4}", singleTableInfo.getStartName());
            editStr = editStr.replace("${templateCode5}", singleTableInfo.getHumpName());
            String listFileName = TEMPLATE_HTML_DIR + singleTableInfo.getHumpName() + File.pathSeparator + "list.jsp";
            String editFileName = TEMPLATE_HTML_DIR + singleTableInfo.getHumpName() + File.pathSeparator + "edit.jsp";
            stringToFile(listFileName, listStr);
            stringToFile(editFileName, editStr);
        }
    }

    public void makeForm() {
        String templateCode = fileToString(FROM_TEMPLATE_NAME);
        for (SingleTableInfo singleTableInfo : singleTableInfos) {
            String str = templateCode.replace("${templateCode1}", singleTableInfo.getTableName());
            str = str.replace("${templateCode2}", singleTableInfo.bigHumpName());
            String fileName = TEMPLATE_FORM_DIR + singleTableInfo.bigHumpName() + "FormMap";
            stringToFile(fileName, str);
        }
    }

    public void makeAction() {
        String templateCode = fileToString(ACTION_TEMPLATE_NAME);
        for (SingleTableInfo singleTableInfo : singleTableInfos) {
            String str = templateCode.replace("${templateCode1}", singleTableInfo.getHumpName());
            str = str.replace("${templateCode2}", singleTableInfo.bigHumpName());
            str = str.replace("${templateCode3}", singleTableInfo.getStartName());
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
                stringBuilder.append(lineStr);
            }
            return stringBuilder.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public SingleTableInfo buildSingleTableInfo(String tableStr) {
        String tableName = tableStr.substring(tableStr.indexOf("EXISTS `") + 8, tableStr.lastIndexOf("`"));
        List<Property> properties = new ArrayList<>();
        String humpName = humpName(tableName);
        String startName = tableName.substring(0, tableName.indexOf("_"));
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
            newTableName = newTableName.substring(0, index) + newTableName.substring(index + 1, index + 2).toUpperCase() + newTableName.substring(index + 1);
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

}
