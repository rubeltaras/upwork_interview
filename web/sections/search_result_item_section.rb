# This class is example of section
class SearchResultItemSection < Howitzer::Web::Section
  me 'section.air-card-hover'

  element :rate_container, '.oRate strong'
  element :skills_items, '[data-skill] em'

  def rate
    rate_container_element.text.gsub(/[^\d\.]+/, '').to_f
  end

  def skills
    skills_items_elements.map(&:text)
  end
end
