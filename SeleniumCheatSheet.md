
### API workthough

1.	Open a browser
	
		# start an instance of firefox with selenium-webdriver
		driver = Selenium::WebDriver.for :firefox
		# :chrome -> chrome
		# :ie     -> iexplore

*	Go to a specified URL

		driver.get 'http://google.com'
		driver.navigate.to 'http://google.com'
		
	`NOTE` -- the WebDriver may not wait for the page to load, you'd better using explicit and implicit waits.
	
*	Locating Elements

	*	`find_element` -- Find the first element matching the given arguments.
	
	*	`find_elements` -- Find all elements matching the given arguments

	*	By ID

			# example html
			# <input id="q">...</input>
				
			element = driver.find_element(:id, "q")
		
	*	By Class Name
	
			# example html
			# <div class="highlight-java" style="display: none; ">...</div>
			
			element = driver.find_element(:class, 'highlight-java')
			# or
			element = driver.find_element(:class_name, 'highlight-java')
		
	*	By Tag Name
			
			# example html
			# <div class="highlight-java" style="display: none; ">...</div>
			
			element = driver.find_element(:tag_name, 'div')
			
	*	By Name
			
			# example html
			# <input id="q" name='search' type='text'>…</input>
			
			element = driver.find_element(:name, 'search')
		

	*	By Link Text
			
			# example html
			# <a href="http://www.google.com/search?q=cheese">cheese</a>
			
			element = driver.find_element(:link, 'cheese')
			# or			
			element = driver.find_element(:link_text, 'cheese')

	*	By Partial Link Text
	
			# example html
			# <a href="http://www.google.com/search?q=cheese">search for cheese</a>			
			element = driver.find_element(:partial_link_text, 'cheese')	
	*	By XPath
	
			# example html
			# <ul class="dropdown-menu">
            #   <li><a href="/login/form">Login</a></li>
            #   <li><a href="/logout">Logout</a></li>
            # </ul>
  			
			element = driver.find_element(:xpath, '//a[@href='/logout']')
			
		*	`NOTE` -- When using Element#find_element with `:xpath`, be aware that,
	
			*	 webdriver follows standard conventions: a search prefixed with "//" will search the entire document, not just the children of this current node. 
			*	Use ".//" to limit your search to the children of the receiving Element.
			
	* By CSS Selector
	
			# example html
			# <div id="food">
			#   <span class="dairy">milk</span>
			#   <span class="dairy aged">cheese</span>
			# </div>
			
			element = driver.find_element(:css, #food span.dairy)
			
*	Element's operation

	*	Button/Link/Image
	
			driver.find_element(:id, 'BUTTON_ID).click
	
	*	Text Filed
	
			# input some text
			driver.find_element(:id, 'TextArea').send_keys 'InputText'
			# send keyboard actions, press `ctral+a` & `backspace`
			driver.find_element(:id, 'TextArea').send_keys [:contol, 'a'], :backspace

	*	Checkbox/Radio
	
			# check if it is selected
			driver.find_element(:id, 'CheckBox').selected?
			# select the element
			driver.find_element(:id, 'CheckBox').click
			# deselect the element
			driver.find_element(:id, 'CheckBox').clear
	
	*	Select
	
			# get the select element	
			select = driver.find_element(:tag_name, "select")
			# get all the options for this element
			all_options = select.find_elements(:tag_name, "option")
			# select the options
			all_options.each do |option|
			 puts "Value is: " + option.attribute("value")
			 option.click
			end
			
			# anthoer way is using the Select class after seleniun-webdriver 2.14		
			element= driver.find_element(:tag_name,"select")
			select=Selenium::WebDriver::Support::Select.new(element)
		    select.deselect_all()
		    select.select_by(:text, "Edam")

	*	visibility
			
			driver.find_element(:id,'Element').displayed?
			
	*	get text
				
			driver.find_element(:id,'Element').text
	
	*	get attribue
			
			driver.find_element(:id, 'Element').attribute('class')
			
*	Driver's operation

	* execute javascript

			driver.execute_script("return window.location.pathname")
			
	* wait for a specific element to show up
			
			# set the timeout to 10 seconds
			wait = Selenium::WebDriver::Wait.new(:timeout => 10)
			# wait 10 seconds until the element appear
			wait.until { driver.find_element(:id => "foo") }
	
	* implicit waits

	An implicit wait is to tell WebDriver to poll the DOM for a certain amount of time when trying to find an element or elements if they are not immediately available
	
			driver = Selenium::WebDriver.for :firefox
			# set the timeout for implicit waits as 10 seconds
			driver.manage.timeouts.implicit_wait = 10
			
			driver.get "http://somedomain/url_that_delays_loading"
			element = driver.find_element(:id => "some-dynamic-element")
			
	* send key strokes to the DOM (Supported keys using `driver.action.send_keys(key).perform`)
			
			:null
			:cancel
			:help
			:backspace
			:tab
			:clear
			:return
			:enter
			:shift
			:left_shift
			:control
			:left_control
			:alt
			:left_alt
			:pause
			:escape
			:space
			:page_up
			:page_down
			:end
			:home
			:left
			:arrow_left
			:up
			:arrow_up
			:right
			:arrow_right
			:down
			:arrow_down
			:insert
			:delete
			:semicolon
			:equals
			:numpad0
			:numpad1
			:numpad2
			:numpad3
			:numpad4
			:numpad5
			:numpad6
			:numpad7
			:numpad8
			:numpad9
			:multiply
			:add
			:separator
			:subtract
			:decimal
			:divide
			:f1
			:f2
			:f3
			:f4
			:f5
			:f6
			:f7
			:f8
			:f9
			:f10
			:f11
			:f12
			:meta
			:command

	* switch between frames
	
			# switch to a frame
			driver.switch_to.frame "some-frame" # name or id
			driver.switch_to.frame driver.find_element(:id, 'some-frame') # frame element
			
			# switch back to the main document
			driver.switch_to.default_content
				
	* swich between windows
	
			driver.window_handles.each do |handle|
     		  driver.switch_to.window handle
			end
			
	* handle javascript dialog
		
			# get the alert
			a = driver.switch_to.alert
			# operation on the alert
			if a.text == 'A value you are looking for'
			  a.dismiss
			else
			  a.accept
			end

* Cookies
	
	* Delete cookies
	
			# You can delete cookies in 2 ways
			# By name
			driver.manage.delete_cookie("CookieName")
			# Or all of them
			driver.manage.delete_all_cookies