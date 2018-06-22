import org.junit.Test;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.jsoup.Jsoup;
import org.jsoup.helper.Validate;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class PersonalBankingTests {

    @Test
    public void testImage() {
        String text = "";
        try {
            text = new String(Files.readAllBytes(Paths.get("src/main/webapp/WEB-INF/jsp/welcome.jsp")));

            assertThat("Loans image is present", text.indexOf("loans.jpg"), not(-1));
        } catch(IOException e){
            System.out.println("Image not found");
        }
    }
}
