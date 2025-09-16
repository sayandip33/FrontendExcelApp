import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;

PolicyFactory policy = Sanitizers.FORMATTING.and(Sanitizers.LINKS);
// Then sanitize your output
output = "<h1>" + policy.sanitize(hostname2) + "</h1>";
