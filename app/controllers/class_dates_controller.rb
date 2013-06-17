class ClassDatesController < ApplicationController
  before_filter :authenticate_admin
  respond_to :html, :js

  # GET /class_dates/1
  def show
    @class_date = ClassDate.find(params[:id])
    @response_email = ResponseEmail.find_by_purpose("follow_up")
  end

  # POST /class_dates
  def create
    @library_class = LibraryClass.find(params[:class_date][:library_class_id])
    @class_date = ClassDate.new(params[:class_date])
    if @class_date.save
      flash[:notice] = t('class_dates.flash.create.notice')
    else
      flash[:error] = t('class_dates.flash.create.error')
    end
    respond_with(@class_date) do |format|
      format.html { redirect_to @library_class }
    end
  end

  # DELETE /class_dates/1
  def destroy
    @class_date = ClassDate.find(params[:id])
    flash[:notice] = t('class_dates.flash.destroy.notice') if @class_date.destroy
    respond_with(@class_date, :location => @class_date.library_class)
  end  
  
  # GET /class_dates/1/edit
  def edit
    @class_date = ClassDate.find(params[:id])
    @library_class = @class_date.library_class
    respond_with(@class_date)
  end
  
  # PUT /class_dates/1
  def update
    @class_date = ClassDate.find(params[:id])
    @library_class = @class_date.library_class
    flash[:notice] = t('class_dates.flash.update.notice') if @class_date.update_attributes(params[:class_date])
    respond_with(@class_date) do |format|
      format.js { render :nothing => true }
    end
  end
  
  # POST /class_dates/send_follow_up
  def send_follow_up
    @class_date = ClassDate.find(params[:class_date])
    @registrations = @class_date.registrations
    flash[:notice] = t("class_dates.flash.send_follow_up.notice") if RegistrationMailer.follow_up_email(ResponseEmail.new(params[:response_email]), @registrations).deliver
    respond_with(@class_date)
  end

end
