require 'rest_client'
require 'yaml'

module Utilities

  def self.set_browser(name)
    case ENV['TARGET']
      when 'local'
        self.local_capabilities
      when 'sauce_labs'
        self.sauce_capabilities(name)
      else
        self.local_capabilities
    end
  end

  def self.sauce_capabilities(name)
    # caps = Selenium::WebDriver::Remote::Capabilities.iphone
    #caps = Selenium::WebDriver::Remote::Capabilities.internet_explorer
    #caps[:platform] = "Windows 10"
    #caps[:browserName] = "chrome"
    #caps[:version] = "11.03"
    # caps[:deviceName] = "iPad 2"
    # caps[:deviceOrientation] = 'landscape'

    # caps = Selenium::WebDriver::Remote::Capabilities.iphone
    # caps[:deviceName] = "iPad Air 2 Simulator"
    # caps[:deviceOrientation] = "portrait"
    # caps[:platformName] = "iOS"
    # caps[:browserName] = "Safari"

    # caps = Selenium::WebDriver::Remote::Capabilities.safari()
    # caps[:platform] = 'OS X 10.11'
    # caps[:version] = '9.0'

    caps = Selenium::WebDriver::Remote::Capabilities.chrome()
    caps[:platform] = 'Windows 7'
    caps[:version] = '49.0'

    # caps = Selenium::WebDriver::Remote::Capabilities.firefox()
    # caps[:platform] = 'OS X 10.11'
    # caps[:version] = '48.0'

    # caps = Selenium::WebDriver::Remote::Capabilities.internet_explorer()
    # caps[:platform] = 'Windows 7'
    # caps[:version] = '8.0'

    caps[:name] = name
    return Watir::Browser.new(:remote, url: self.sauce_server_url, desired_capabilities: caps)
  end

  def self.local_capabilities
    Watir::Browser.new :chrome
  end
  def self.sauce_auth_details
    # "#{ENV[:SAUCE_USERNAME]}:#{ENV[:SAUCE_ACCESS_KEY]}"
  end

  def self.sauce_server_url
    "http://#{sauce_auth_details}@ondemand.saucelabs.com:80/wd/hub"
  end

  def self.maximize_browser_window(browser)
    screen_width = browser.execute_script('return screen.width;')
    screen_height = browser.execute_script('return screen.height;')
    browser.driver.manage.window.resize_to(screen_width, screen_height)
    browser.driver.manage.window.move_to(0, 0)
  end

  def self.set_browser_size_mobile(browser)
    browser.driver.manage.window.resize_to(375, 667)
    browser.driver.manage.window.move_to(0, 0)
  end

  def self.set_browser_size_tablet(browser)
    browser.driver.manage.window.resize_to(800, 980)
    browser.driver.manage.window.move_to(0, 0)
  end

  def self.sauce_rest_jobs_url
    # "https://#{sauce_auth_details}@saucelabs.com/rest/v1/#{ENV[:SAUCE_USERNAME]}/jobs"
    #"https://#{sauce_auth_details}@saucelabs.com/rest/v1/wdelacruz_walle/jobs"
    "https://#{sauce_auth_details}@saucelabs.com/rest/v1/cdiaztello/jobs"
  end

  # Because WebDriver doesn't have the concept of test failure, use the Sauce
  # Labs REST API to record job success or failure
  def self.sauce_update_job_success(appium, success)
    job_id = appium.driver.send(:bridge).session_id
    RestClient.put "#{sauce_rest_jobs_url}/#{job_id}", {'passed' => success}.to_json, :content_type => :json
  end



end