require File.join(File.dirname(__FILE__), "abstract_page.rb")

class LoginPage < AbstractPage
  include RSpec::Matchers

  def initialize(driver)
    super(driver, "")
  end

  def enter_username(username)
    driver.find_element(:xpath, "//*[@id='identifierId']").clear
    driver.find_element(:xpath, "//*[@id='identifierId']").send_keys(username)
  end

  def click_login_next
    driver.find_element(:id,"identifierNext").click
    sleep 0.5
  end

  def verify_login_page_password
    driver.find_element(:id, "password")
  end

  def enter_password(password)
    driver.find_element(:name, "password").click
    driver.find_element(:name, "password").clear
    driver.find_element(:name, "password").send_keys(password)
  end

  def click_login
    driver.find_element(:id,"passwordNext").click
    sleep 0.5
  end

  def click_cancel
    driver.find_element(:xpath, "//button[@value=\"cancel\"]").click
    sleep 0.5
  end

  def click_allow
    allows = driver.find_elements(:xpath, "//button[@value=\"yes\"]")
    allows.each { |allow| allow.click }
    sleep 0.5
  end

  def click_do_not_allow
    do_not_allows = driver.find_elements(:xpath, "//button[@value=\"no\"]")
    do_not_allows.each { |do_not_allow| do_not_allow.click }
    sleep 0.5
  end

end
