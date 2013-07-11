class RegistrationsController < ApplicationController
  before_filter :authenticate_admin
  respond_to :html, :js
  
  # PUT /registrations/1
  def update
    @registration = Registration.find(params[:id])
    flash[:notice] = t("registrations.flash.update.notice") if @registration.update_attributes(params[:registration])
    respond_with(@registration, :location => @registration.class_date) do |format|
      format.js { render :nothing => true }
    end
  end

  # DELETE /registrations/1
  def destroy
    @registration = Registration.find(params[:id])
    flash[:notice] = t("registrations.flash.destroy.notice") if @registration.destroy
    respond_with(@registration, :location => @registration.class_date)
  end

end
