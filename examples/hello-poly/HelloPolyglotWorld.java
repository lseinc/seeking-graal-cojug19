import org.graalvm.polyglot.*;
import java.util.Set;

public class HelloPolyglotWorld {
    public static void main(String[] args) throws Exception {
        System.out.println("Hello polyglot world Java!");
        Context context = Context.newBuilder().allowAllAccess(true).build();
        Set<String> languages = context.getEngine().getLanguages().keySet();
        System.out.println("Current Languages available in GraalVM: " + languages);

        context.eval("js", "print('Hello polyglot world JavaScript!');");
        context.eval("ruby", "puts 'Hello polyglot world Ruby!'");
        context.eval("R", "print('Hello polyglot world R!');");
        context.eval("python", "print('Hello polyglot world Python!');");
    }
}
