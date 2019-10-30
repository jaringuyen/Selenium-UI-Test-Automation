load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Google Login" do
	include TestHelper
  
	before(:all) do
		set_selenium_options
	    @driver.navigate.to $BASE_URL
	    @driver.manage().window().maximize()
	    sign_in("testselenium@gmail.com", "test password")
	end
  
	it "Show Welcome in Google password page" do
	  sleep 1
	  element = @driver.find_element(:css, "#headingText span")
	  expect(element.text).to eq("Welcome")
	  sleep 1
	  printf "done"
	end
  end