require "#{File.dirname(__FILE__)}/../rwebspec_utils.rb"

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage

  # If want to use utility methods such as fail_safe { }, uncomment the line below
  #
  include RWebSpecUtils

  def initialize(driver, text = "")
    page_delay
    @driver = driver
    raise "Page text '#{text}' not found on #{self.class.name}" unless driver.page_source.include?(text)
  end

  def driver
    @driver
  end
  alias browser driver

  def page_delay
	sleep 2
  end
end
