require 'watir'
require 'watir-scroll'
require 'active_record'

Before do
  Data_Access::load
  @scenario_session = Scenario_Session.new
end

#Before('@api_ready') do
Before('@api') do
    clean_database
    create_full_data
    @scenario_session.base_path = FigNewton.api_url
end

Before('~@api') do |scenario|
  Watir.default_timeout = 15
  @browser = Utilities.set_browser(scenario.name)
  #Utilities.maximize_browser_window(@browser)
end

After('~@api') do |scenario|
  if ENV['TARGET'] == 'sauce_labs'
    Utilities.sauce_update_job_success(@browser, !scenario.failed?)
  end
  begin
    if scenario.failed?
      take_screenshot(scenario.name)
    end
  rescue => error
    puts error.to_s
  end
  @browser.close
end

def take_screenshot(scenario_name)
  # filename = "report/screenshots/error-#{scenario_name.gsub(' ', '_').gsub(',', '_')}-#{@scenario_session.start_date_time}.png"
  # @browser.screenshot.save(filename)
  # embed(File.expand_path("#{filename}"), 'image/png', 'Scenario_Failed_Screenshot')
  # attach_file("error-#{scenario_name.gsub(' ', '_').gsub(',', '_')}-#{@scenario_session.start_date_time}",File.expand_path("#{filename}").downcase)
end