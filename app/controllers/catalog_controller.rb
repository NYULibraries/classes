class CatalogController < ApplicationController
  respond_to :html, :js
  
  # GET /
  def index
    @class_categories = ClassCategory.visible
    @library_classes = LibraryClass.visible.in_order
    @user = current_user#User.new
    
    @registration = Registration.new
    @suggestion = Suggestion.new
    
    respond_with(@registration) 
  end
  
  # POST /catalog
  def create
    @class_categories = ClassCategory.visible
    @library_classes = LibraryClass.visible.in_order
    @user = User.find_or_create_by_username(params[:user][:username])
    @user.update_attributes(params[:user])
    @registration = Registration.new
    flash[:notice] = []
    @registrations = []
 
    if @user.save
      unless params[:class_date].nil?
        params[:class_date].each do |class_date|
          # Initialize and save registration
          this_registration = Registration.new
          this_registration.user = @user
          this_registration.class_date_id = class_date.last
          
          # Save suggestion
          @suggestion = Suggestion.new(params[:suggestion])
          @suggestion.fullname = @user.fullname
          @suggestion.username = @user.username
          @suggestion.email = @user.email
          @suggestion.save
          
          if this_registration.save
            flash[:notice] << "You have successfully registered for <strong>#{this_registration.class_date.library_class.title}</strong>.".html_safe
            @registrations << this_registration
            # Send confirmation email 
            RegistrationMailer.confirmation_email(@registrations).deliver
          else
            @registration.errors.add(:base, "You are already registered for <strong>#{this_registration.class_date.library_class.title}</strong> for the selected timeslot.".html_safe)
          end
        end
      else
        @registration.errors.add(:base, t('catalog.flash.create.error'))
      end
    end

    respond_with(@registration) do |format|
      if @user.errors.empty? and @registration.errors.empty?
        format.html { redirect_to root_url }        
      else
        format.html { render :index }
      end
    end
    
  end
  
  # POST /catalog/autofill_user_fields
  def autofill_user_fields
    @user = User.find_by_username(params[:user][:username])
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