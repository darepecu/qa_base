class Google_Page_Results
  include PageObject

  div(:filter_container, :id => 'hdtb-msb-vis')

  def loaded?
    begin
      Watir::Wait.until {
        filter_container_element.exists?
        true
      }
    rescue => error
      puts error.to_s
      false
    end
  end

  def page_should_contains(title)
    browser.text.include?(title).should == true
  end

end