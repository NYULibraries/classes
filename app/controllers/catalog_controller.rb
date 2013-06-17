class CatalogController < ApplicationController
  respond_to :html, :js
  
  # GET /
  def index
    @class_categories = ClassCategory.visible
    @library_classes = LibraryClass.visible.in_order
    @user = (current_user) ? current_user : User.new
    
    @registration = Registration.new
    @suggestion = Suggestion.new
    
    respond_with(@registration) 
  end
  
  # POST /catalog
  def create
    @class_categories = ClassCategory.visible
    @library_classes = LibraryClass.visible.in_order
    @registration = Registration.new
    
    # Find user if exists, or initialize otherwise
    @user = User.find_or_initialize_by_username(params[:user][:username])
    # Then assign the new attrs to this user
    @user.assign_attributes(params[:user])
    
    # Track multiple saved registrations
    @registrations = []
    # With multiple registrations, come multiple flash notices
    flash[:notice] = []
 
    # Save user without regard to authlogic session maintenance
    if @user.save_without_session_maintenance
      unless params[:class_date].nil?
        params[:class_date].each do |class_date|
          # Initialize and save each registration
          this_registration = Registration.new
          this_registration.user = @user
          this_registration.class_date_id = class_date.last
          
          # Save suggestion
          @suggestion = Suggestion.new(params[:suggestion])
          @suggestion.fullname = @user.fullname
          @suggestion.username = @user.username
          @suggestion.email = @user.email
          @suggestion.save
          
          # Check to see if we can save this registration and if so set a success message and send email
          if this_registration.save
            flash[:notice] << "You have successfully registered for <strong>#{this_registration.class_date.library_class.title}</strong>.".html_safe
            @registrations << this_registration
            # Send confirmation email 
            RegistrationMailer.confirmation_email(@registrations).deliver
          # If we couldn't save it and it wasn't null that's because it's a duplicate record. Print a nice message for 'em
          else
            @registration.errors.add(:base, "You are already registered for <strong>#{this_registration.class_date.library_class.title}</strong> for the selected timeslot.".html_safe)
          end
        end
      # Else there were no class_dates selected, so tell them so
      else
        @registration.errors.add(:base, t('catalog.flash.create.error'))
      end
    end

    # Proudly redirect to root if there are no errors
    # Or, humbly render the errors
    respond_with(@registration) do |format|
      if @user.errors.empty? and @registration.errors.empty?
        format.html { redirect_to root_url }        
      else
        format.html { render :index }
      end
    end
    
  end
  
  # POST /catalog/autofill_user_fields
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