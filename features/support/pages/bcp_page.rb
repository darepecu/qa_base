class Bcp_Page
  include PageObject

  button(:banca_por_internet, :xpath => "//div[contains(@class,'hidden-xs')]//a[@id='bcp-button-hbk-pc']")

  def loaded?
    begin
      Watir::Wait.until {
        banca_por_internet_element.exists?
      }
      true
    rescue => error
      puts error.to_s
      false
    end
  end

end