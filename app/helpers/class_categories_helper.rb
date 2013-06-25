module ClassCategoriesHelper

  # Link to an category URL
  def link_to_class_category_url(class_category)
    if class_category.url?
      link_to(sanitize_title(class_category.title), class_category.url, :target => "_blank")
    else
      sanitize_title(class_category.title)
    end
  end
  
  # Link to an external category list
  def link_to_external_category(class_category)
    if class_category.external? and params[:class_category_id].blank?
      link_to(strip_tags(sanitize_title(class_category.title)), external_category_url(:class_category_id => "#{class_category.id}-#{parameterize_title(class_category.title)}"))
    else
      sanitize_title(class_category.title)
    end
  end
  
end
