require 'rubygems'
require 'selenium-webdriver'
require 'rspec'
require 'httparty'


# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/rwebspec_utils.rb"

# this loads defined page objects under pages folder
require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

# The default base URL for running from command line or continuous build process
$BASE_URL = "https://accounts.google.com/"

module TestHelper
   include RWebSpecUtils

  def set_selenium_options
	options = Selenium::WebDriver::Chrome::Options.new
	options.add_argument('--ignore-certificate-errors')
	options.add_argument('--disable-popup-blocking')
	options.add_argument('--disable-translate')
	options.add_argument('--start-maximized')
	
	@driver = Selenium::WebDriver.for :chrome, options: options
	$browser = @driver
	browser = @driver
    wait = Selenium::WebDriver::Wait.new(:timeout => 5)
    
  end


  def sign_in(login, password)
    login_page = LoginPage.new(@driver)
	try_for(10, 4) {  login_page.enter_username(login) }
	sleep 2
	login_page.click_login_next
	sleep 2
    login_page.enter_password(password)
  end
  
  def sign_out
    try_for(20, 5) { @driver.find_element(:id, "account-menu").click }
    sleep 3
    try_for(20, 5) { @driver.find_element(:id, "sign-out").click }
  end
end
