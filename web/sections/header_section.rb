# This class is example of section
class HeaderSection < Howitzer::Web::Section
  me '.header-navbar:not([class*=hidden])'

  element :search_field, '[class*=visible] [name=q]'

  def fill_and_submit_search_field(query)
    Howitzer::Log.info "Fill search field with #{query}"
    search_field_element.set("#{query}\n")
  end
end
