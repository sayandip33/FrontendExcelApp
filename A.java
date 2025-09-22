import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class DefaultXferForClientID {

    @Value("${defaultxfer.transfer.1200}")
    private String clientId_1200;

    @Value("${defaultxfer.transfer.1201}")
    private String clientId_1201;

    @Value("${defaultxfer.transfer.1203}")
    private String clientId_1203;

    @Value("${defaultxfer.transfer.1205}")
    private String clientId_1205;

    @Value("${defaultxfer.transfer.1207}")
    private String clientId_1207;

    @Value("${defaultxfer.transfer.1208}")
    private String clientId_1208;

    @Value("${defaultxfer.transfer.1210}")
    private String clientId_1210;

    @Value("${defaultxfer.transfer.1220}")
    private String clientId_1220;

    @Value("${defaultxfer.transfer.1221}")
    private String clientId_1221;

    @Value("${defaultxfer.transfer.1222}")
    private String clientId_1222;

    @Value("${defaultxfer.transfer.1224}")
    private String clientId_1224;

    @Value("${defaultxfer.transfer.1225}")
    private String clientId_1225;

    @Value("${defaultxfer.transfer.1226}")
    private String clientId_1226;

    @Value("${defaultxfer.transfer.1227}")
    private String clientId_1227;

    @Value("${defaultxfer.transfer.1228}")
    private String clientId_1228;

    @Value("${defaultxfer.transfer.1229}")
    private String clientId_1229;

    @Value("${defaultxfer.transfer.1230}")
    private String clientId_1230;

    @Value("${defaultxfer.transfer.1231}")
    private String clientId_1231;

    @Value("${defaultxfer.transfer.1232}")
    private String clientId_1232;

    // --- getters ---
    public String getClientId_1200() { return clientId_1200; }
    public String getClientId_1201() { return clientId_1201; }
    public String getClientId_1203() { return clientId_1203; }
    public String getClientId_1205() { return clientId_1205; }
    public String getClientId_1207() { return clientId_1207; }
    public String getClientId_1208() { return clientId_1208; }
    public String getClientId_1210() { return clientId_1210; }
    public String getClientId_1220() { return clientId_1220; }
    public String getClientId_1221() { return clientId_1221; }
    public String getClientId_1222() { return clientId_1222; }
    public String getClientId_1224() { return clientId_1224; }
    public String getClientId_1225() { return clientId_1225; }
    public String getClientId_1226() { return clientId_1226; }
    public String getClientId_1227() { return clientId_1227; }
    public String getClientId_1228() { return clientId_1228; }
    public String getClientId_1229() { return clientId_1229; }
    public String getClientId_1230() { return clientId_1230; }
    public String getClientId_1231() { return clientId_1231; }
    public String getClientId_1232() { return clientId_1232; }

    // --- method to return map ---
    public Map<String, String> getAllAsMap() {
        Map<String, String> map = new HashMap<>();
        map.put("1200", clientId_1200);
        map.put("1201", clientId_1201);
        map.put("1203", clientId_1203);
        map.put("1205", clientId_1205);
        map.put("1207", clientId_1207);
        map.put("1208", clientId_1208);
        map.put("1210", clientId_1210);
        map.put("1220", clientId_1220);
        map.put("1221", clientId_1221);
        map.put("1222", clientId_1222);
        map.put("1224", clientId_1224);
        map.put("1225", clientId_1225);
        map.put("1226", clientId_1226);
        map.put("1227", clientId_1227);
        map.put("1228", clientId_1228);
        map.put("1229", clientId_1229);
        map.put("1230", clientId_1230);
        map.put("1231", clientId_1231);
        map.put("1232", clientId_1232);
        return map;
    }
}
