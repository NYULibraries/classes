# app/views/layouts/bobcat.rb
module Views
  module Layouts
    class Application < ActionView::Mustache
      # Meta tags to include in layout
      def meta
        meta = super
        meta << tag(:meta, :fullname => "HandheldFriendly", :content => "True")
        meta << tag(:meta, :fullname => "cleartype", :content => "on")
        meta << favicon_link_tag('https://library.nyu.edu/favicon.ico')
      end
      
      def application_title
        t("application_title")
      end
      
      # Stylesheets to include in layout
      def stylesheets
        catalog_stylesheets
      end
      
      # Javascripts to include in layout
      def javascripts
        catalog_javascripts
      end
            
      # Print breadcrumb navigation
      def breadcrumbs
        breadcrumbs = [link_to("NYU Libraries", "https://library.nyu.edu")]
        breadcrumbs << link_to_unless_current(application_title, root_url)
        breadcrumbs << link_to("Admin", class_categories_path) if is_in_admin_view?
        breadcrumbs << link_to_unless_current(controller.controller_name.humanize) unless controller.controller_name == "catalog"
        return breadcrumbs
      end
      
      # Render footer partial
      def footer
        render :partial => 'common/footer'
      end
      
      # Prepend modal dialog elements to the body
      def prepend_body
        prepend_body = '<div class="modal-container"></div>'.html_safe
        prepend_body << '<div id="ajax-modal" class="modal hide fade" tabindex="-1"></div>'.html_safe
      end
      
      # Prepend the flash message partial before yield
      def prepend_yield
        content_tag :div, :id => "main-flashses" do
         render :partial => 'common/flash_msg'
        end
      end
        
      # Boolean for whether or not to show tabs
      def show_tabs
        return false
      end
            
    end
  end
end