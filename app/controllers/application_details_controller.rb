class ApplicationDetailsController < ApplicationController
  before_filter :authenticate_admin
  respond_to :html, :json

  # GET /application_details/1/edit
  def edit
    @application_detail = ApplicationDetail.find(params[:id])
    respond_with(@application_detail)
  end

  # PUT /application_details/1
  def update
    @application_detail = ApplicationDetail.find(params[:id])
    flash[:notice] = t('application_details.flash.update.notice') if @application_detail.update_attributes(params[:application_detail])
    respond_with(@application_detail) do |format|
      format.html { redirect_to library_classes_url }
    end
  end

end
