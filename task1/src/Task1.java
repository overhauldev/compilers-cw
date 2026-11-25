import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.io.IOException;

public class Task1 {

    public static void main(String[] args) throws IOException {
        // create a CharStream that reads from standard input
        CharStream input = CharStreams.fromString("int main() {\n" +
                "    int a := 7;\n" +
                "    a\n" +
                "}");
        // create a lexer that feeds off of input CharStream
        SimpleLangLexer lexer = new SimpleLangLexer(input);

        // create a buffer of tokens pulled from the lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // create a parser that feeds off the tokens buffer
        SimpleLangParser parser = new SimpleLangParser(tokens);
        SimpleLangParser.ProgContext tree = parser.prog(); // begin parsing at prog rule
        if (parser.getNumberOfSyntaxErrors() == 0) {
            System.out.println("PARSE SUCCESS");

            SimpleLangInterpreter interpreter = new SimpleLangInterpreter();
            Integer result = interpreter.visitProgram(tree, args);

            System.out.println("NORMAL_TERMINATION");
            System.out.println(result);
        } else {
            System.out.println("PARSE FAILED");
        }
    }
}