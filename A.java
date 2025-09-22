@Component
@ConfigurationProperties(prefix = "defaultxfer")
public class DefaultXferForClientID {

    private Map<String, String> transfer;

    public Map<String, String> getTransfer() {
        return transfer;
    }

    public void setTransfer(Map<String, String> transfer) {
        this.transfer = transfer;
    }
}


@RestController
public class DemoController {

    private final DefaultXferForClientID clientID;

    public DemoController(DefaultXferForClientID clientID) {
        this.clientID = clientID;
    }

    @GetMapping("/hi")
    public Map<String, String> test() {
        return clientID.getTransfer();
    }
}



defaultxfer:
	  transfer:
	    1200: 8773554664
	    1201: 8773554810
	    1203: 8773555116
	    1205: 8773555209
	    1207: 8004214488
	    1208: 8446683680
	    1210: 8773550488
	    1220: 2014134601
	    1221: 8558118182
	    1222: 8009339946
	    1224: 8774724200
	    1225: 8442923659
	    1226: 8445691140
	    1227: 8447031200
	    1228: 8445691138
	    1229: 8445691137
	    1230: 8334780153
	    1231: 8444280556
	    1232: 8664587585
