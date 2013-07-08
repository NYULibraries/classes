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
        breadcrumbs << link_to_unless_current(strip_tags(@class_categories.first.title).titleize, external_category_url(:class_category_id => "#{@class_categories.first.id}-#{parameterize_title(@class_categories.first.title)}")) unless params[:class_category_id].blank? or is_in_admin_view?
        breadcrumbs << link_to("Admin", class_categories_path) if is_in_admin_view?
        breadcrumbs << link_to_unless_current(controller.controller_name.humanize) unless controller.controller_name == "catalog"
        return breadcrumbs
      end
      
      # Using Gauges?
      def gauges?
        (Rails.env.eql?("production") and (not gauges_tracking_code.nil?))
      end
      
      def gauges_tracking_code
        Settings.gauges.tracking_code
      end
      
      # Render footer partial
      def footer
        render :partial => 'common/footer'
      end
      
      # Prepend modal dialog elements to the body
      def prepend_body
        content_tag(:div, nil, :class => "modal-container")+
        content_tag(:div, nil, :id => "ajax-modal", :class => "modal hide fade", :tabindex => "-1")
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
      
      # Login link and icon
      def login(params={})
        (!@current_user.nil?) ? link_to_logout : link_to_login
      end

      # Link to logout
      def link_to_logout
        icon_tag(:logout) +
          link_to("Log-out #{@current_user.firstname}", 
            logout_url, class: "logout")
      end

      # Link to logout
      def link_to_login
        icon_tag(:login) + link_to("Login", login_url, class: "login")
      end
            
    end
  end
end