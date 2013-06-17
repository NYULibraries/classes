module ClassCategoriesHelper

  # Link to an external category or a URL
  def link_to_external_list_or_url(class_category)
    if class_category.external?
      link_to(class_category.title_sanitized, class_category)
    elsif class_category.url?
      link_to(class_category.title_sanitized, class_category.url, :target => "_blank")
    else
      class_category.title_sanitized
    end
  end
  
end
