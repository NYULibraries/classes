class ResponseEmailsController < ApplicationController
  before_filter :authenticate_admin
  respond_to :html
  
  # GET /response_emails
  def index
    @response_emails = ResponseEmail.find(:all)
    respond_with(@response_emails)
  end

  # GET /response_emails/1/edit
  def edit
    @response_email = ResponseEmail.find(params[:id])
    respond_with(@response_email)
  end

  # PUT /response_emails/1
  def update
    @response_email = ResponseEmail.find(params[:id])
    
    respond_with(@response_email) do |format|
      if @response_email.update_attributes(params[:response_email])
        flash[:notice] = t('response_emails.flash.update.notice')
        format.html { redirect_to response_emails_url }
      else
        format.html { render :edit }
      end
    end
  end

end
