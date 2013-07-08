class CatalogController < ApplicationController
  respond_to :html, :js
  
  # GET /
  def index
    @class_categories = (params[:class_category_id].blank?) ? ClassCategory.visible : [ClassCategory.find(params[:class_category_id]) ]
    @library_classes = (params[:class_category_id].blank?) ? LibraryClass.visible.non_external.in_order : ClassCategory.find(params[:class_category_id]).library_classes.visible.in_order

    @user = (!@current_user.nil?) ? @current_user : User.new
    
    @registration = Registration.new
    @suggestion = Suggestion.new
    
    respond_with(@registration) and return# unless performed?
  end
  
  # POST /catalog
  def create
    @class_categories = (params[:class_category_id].blank?) ? ClassCategory.visible : [ClassCategory.find(params[:class_category_id])]
    @library_classes = (params[:class_category_id].blank?) ? LibraryClass.visible.non_external.in_order : ClassCategory.find(params[:class_category_id]).library_classes.visible.in_order

    @registration = Registration.new
    @suggestion = Suggestion.new(params[:suggestion])
    
    # Find user if exists, or initialize otherwise
    @user = User.find_or_initialize_by_username(params[:user][:username])
    # Then assign the new attrs to this user
    @user.assign_attributes(params[:user])
    
    # Track multiple saved registrations
    registrations, flash[:notice] = [], []
 
    # Save user without regard to authlogic session maintenance
    if @user.save_without_session_maintenance
      class_dates = params[:class_date].collect { |cd| {class_date_id: cd.last} } unless params[:class_date].blank?

      @user.registrations.create(class_dates) { |reg|
        if reg.valid?
          flash[:notice] << "You have successfully registered for <strong>#{reg.class_date.library_class.title}</strong>.".html_safe 
          registrations << reg
        end
      }
      @user.suggestions.create params[:suggestion] unless registrations.empty?
      
      # Send confirmation email for valid registrations
      RegistrationMailer.confirmation_email(registrations).deliver
    end

    # Proudly redirect to root if there are no errors
    # Or, humbly render the errors
    respond_with(@user) do |format|
      if @user.errors.empty? and @user.registrations.all?(&:valid?)
        format.html { redirect_to root_url }        
      else
        format.html { render :index }
      end
    end
    
  end

  # GET /catalog/autofill_user_fields
  #
  # Submit the user form when the username was filled in and attempt to find that user
  # Render the form, either blank or with the populated fields from @user if found
  def autofill_user_fields
    @user = User.find_or_initialize_by_username(params[:user][:username])
    @registration = Registration.new
    @suggestion = Suggestion.new
    respond_to do |format|
      return render :partial => "catalog/user"
    end  
  end
  
  # GET /suggest
  def new_suggestion
    @suggestion = Suggestion.new
  end
  
  # POST /create_suggestion
  def create_suggestion
    @suggestion = Suggestion.new(params[:suggestion])
    
    respond_with(@suggestion) do |format|
      if @suggestion.save
        format.html { redirect_to root_url, notice: t('catalog.flash.create_suggestion.notice') }
      else
        format.html { render :new_suggestion }
      end
    end
  end

end