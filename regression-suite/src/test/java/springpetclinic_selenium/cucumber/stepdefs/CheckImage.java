package springpetclinic_selenium.cucumber.stepdefs;

import java.util.List;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import springpetclinic_selenium.utils.Configure;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import static org.junit.Assert.*;

public class CheckImage {

	private HtmlUnitDriver driver = new HtmlUnitDriver();

	Configure config = new Configure();

  @Given("^I am on the landing page$")
	public void i_am_on_the_home_page() throws Throwable {
        if(config.getZapEnabled()){
            driver.setProxy(config.getZapIp(), config.getZapPort());
        }
   	Logger logger = Logger.getLogger("");
  	logger.setLevel(Level.OFF);

    for(int i = 0 ; i < 6; i++) {
      driver.get(config.getPetClinicUrl());

      try {
        WebElement email = driver.findElement(By.id("email"));
        break;
      } catch (Exception e) {
        System.out.println("Cannot find specified element");
        Thread.sleep(5000);
      }
    }

	}

  @Then("^The \"(.*?)\" image is \"(.*?)\"$")
	public void image_should_be(String arg1, String arg2) throws Throwable {

    List<WebElement> images = driver.findElements(By.tagName("img"));
    List<String> sources = new ArrayList();

    for(int i = 0; i < images.size(); i++) {
      String str=images.get(i).getAttribute("src");
      int index=str.lastIndexOf('/');
      sources.add(str.substring(index+1));
    }

    assertTrue(sources.contains(arg2));
	}
}
