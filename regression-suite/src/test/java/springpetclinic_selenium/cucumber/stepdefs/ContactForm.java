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

public class ContactForm {

	private HtmlUnitDriver driver = new HtmlUnitDriver();

	Configure config = new Configure();

  @Given("^I am on a page with the contact form$")
	public void i_am_on_the_home_page() throws Throwable {
        if(config.getZapEnabled()){
            driver.setProxy(config.getZapIp(), config.getZapPort());
        }
   	Logger logger = Logger.getLogger("");
  	logger.setLevel(Level.OFF);
		driver.get(config.getPetClinicUrl());
	}

  @Then("^I should see thank you message")
	public void i_should_see_thank() throws Throwable {
    WebElement thank_you = driver.findElementById("thank");
    driver.setJavascriptEnabled(true);
    String display = thank_you.getCssValue("display");
    assertTrue(display != "none");
	}

  @Then("^I should not see thank you message")
	public void i_should_not_see_thank() throws Throwable {
    WebElement thank_you = driver.findElementById("thank");
    driver.setJavascriptEnabled(true);
    String display = thank_you.getCssValue("display");
    assertTrue(display != "visible");
	}

  @Then("^I should see a form with ID \"(.*?)\"$")
	public void i_should_see_form(String arg1) throws Throwable {
    driver.get(config.getPetClinicUrl());
    WebElement form = driver.findElementById(arg1);
    assertTrue(form != null);
	}

	@When("^I fill in \"(.*?)\" with \"(.*?)\"$")
	public void i_fill_in_with(String arg1, String arg2) throws Throwable {
    WebElement field = driver.findElementById(arg1);
    field.sendKeys(arg2);
	}

	@When("^I press \"(.*?)\"$")
	public void i_press(String arg1) throws Throwable {
		WebElement button = driver.findElementById("contactButton");
    button.click();
    Thread.sleep(2000);
	}
}
