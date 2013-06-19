module ClassCategoriesHelper

  # Link to an category URL
  def link_to_class_category_url(class_category)
    if class_category.url?
      link_to(class_category.title_sanitized, class_category.url, :target => "_blank")
    else
      class_category.title_sanitized
    end
  end
  
  # Link to an external category list
  def link_to_external_category(class_category)
    if class_category.external? and !@class_category
      link_to(strip_tags(class_category.title_sanitized), external_category_url(:id => "#{class_category.id}-#{class_category.title_formatted}"))
    else
      class_category.title_sanitized
    end
  end
  
end
