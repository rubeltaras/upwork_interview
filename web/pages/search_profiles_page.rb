class SearchProfilesPage < Howitzer::Web::Page
  path '/o/profiles/browse'
  validate :title, /^Top(.*)For Hire In(.*)- Upwork$/
  validate :url,   /^https?:\/\/[^\/]+\/o\/profiles\/browse.*$/

  section :search_result_item

  element :categories_select, '[data-qa="categories-container"]'
  element :category_option,   ->(c) { "[data-qa='category:#{c}']" }
  element :rates_select,      '[data-facetname=rate]'
  element :rate_option,       ->(r) { "[data-facet-html='#{r}']" }
  element :search_button,     :xpath, '//button[normalize-space()="Search"]'
  # element :wait,  :xpath, "//a[text()='Web, Mobile & Software Dev']"

  def search_results(limit)
    search_result_item_sections[0...limit].map do |section|
      {
        rate: section.rate,
        skills: section.skills
      }
    end
  end

  def search(criteria)
    select_category(criteria[:category])
    select_rate(criteria[:rate])
    click_search_button
    has_category_option_element?(criteria[:category], visible: true)    #wait for angular load search results
  end

  def select_category(category)
    Howitzer::Log.info "Select category: #{category}"
    categories_select_element.click
    category_option_element(category.parameterize).click
  end

  def select_rate(rate)
    Howitzer::Log.info "Select hourly rate: #{rate}"
    rates_select_element.click
    rate_option_element(rate).click
  end

  def click_search_button
    Howitzer::Log.info 'Click Search button'
    search_button_element.click
  end
end