package springpetclinic_selenium.cucumber.stepdefs;

import java.util.List;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

import springpetclinic_selenium.utils.Configure;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import static org.junit.Assert.*;

public class BrowsingAround {

	private HtmlUnitDriver driver = new HtmlUnitDriver();

	Configure config = new Configure();

	@Given("^I am on the home page$")
	public void i_am_on_the_home_page() throws Throwable {
        if(config.getZapEnabled()){
            driver.setProxy(config.getZapIp(), config.getZapPort());
        }
   	 Logger logger = Logger.getLogger("");
  	logger.setLevel(Level.OFF);
		driver.get(config.getPetClinicUrl());
	}

	@Then("^I should see a tile called \"(.*?)\"$")
	public void i_should_see_tile(String arg1) throws Throwable {

    List<WebElement> links = driver.findElements(By.className("links"));
    List<WebElement> children = links.get(0).findElements(By.tagName("a"));

    ArrayList<String> tiles = new ArrayList();
    for(int i = 0; i < children.size(); i++) {
      tiles.add(i, children.get(i).getText());
    }

    assertTrue(tiles.contains(arg1));
	}

}
