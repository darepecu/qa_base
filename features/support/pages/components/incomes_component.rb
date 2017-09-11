class Incomes_Component
  include PageObject

  ROOT_ELEMENT_LOCATOR ||= "//div[contains(@id,'workdetail')]"

  element(:printed_work_type, :span, :xpath => ".//span[@id='s_work_type']")
  element(:printed_work_place, :strong, :xpath => ".//strong[@id='s_work_place']")
  element(:printed_work_category, :span, :xpath => ".//span[@id='s_work_category']")
  element(:printed_work_since_month, :span, :xpath => ".//span[@id='s_work_since_month']")
  element(:printed_work_since_year, :span, :xpath => ".//span[@id='s_work_since_year']")
  element(:printed_gross_income, :span, :xpath => ".//span[@id='s_gross_income']")

  element(:change, :button, :xpath => ".//button[contains(@id,'btn_profession')]")

  def get_work_type
    printed_work_type_element.when_present(30).text.capitalize
  end

  def get_work_place
    printed_work_place_element.when_present(30).text
  end

  def get_work_category
    printed_work_category_element.when_present(30).text
  end

  def get_work_since_month
    printed_work_since_month_element.when_present(30).text
  end

  def get_work_since_year
    printed_work_since_year_element.when_present(30).text
  end

  def get_gross_income
    printed_gross_income_element.when_present(30).text
  end

  def change_income
    change_element.when_present(30).click
  end

  def get_income

  end

end