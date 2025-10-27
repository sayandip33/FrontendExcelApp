import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class EncodeUrlExample {
    public static void main(String[] args) {
        String baseUrl = "https://internal.api.cloud.247-inc.net/bnymellon/v1";
        String target = "https://ivr-services.qa.bnymellon.com";

        String encodedTarget = URLEncoder.encode(target, StandardCharsets.UTF_8);
        String finalUrl = baseUrl + "?targeturl=" + encodedTarget;

        System.out.println(finalUrl);
    }
}
