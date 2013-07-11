class SuggestionsController < ApplicationController
  before_filter :authenticate_admin
  respond_to :html, :js, :csv
  
  # List suggestions with sort and search options
  def index
    @suggestions = Suggestion.search(params[:q]).sorted(params[:sort], "created_at ASC").page(params[:page]).per(30)
    respond_with(@suggestions)
  end
  
  # GET /suggestions/1
  def show
    @suggestion = Suggestion.find(params[:id])
    respond_with(@suggestion)
  end

  # GET /suggestions/1/edit
  def edit
    @suggestion = Suggestion.find(params[:id])
    respond_with(@suggestion)
  end

  # POST /suggestions
  def create
    @suggestion = Suggestion.new(params[:suggestion])

    respond_with(@suggestion) do |format|
      if @suggestion.save
        flash[:notice] = t('suggestions.flash.create.notice')
        format.html { redirect_to root_url }
      end
    end
  end

  # PUT /suggestions/1
  def update
    @suggestion = Suggestion.find(params[:id])
    flash[:notice] = t('suggestions.flash.update.notice') if @suggestion.update_attributes(params[:suggestion])
    respond_with(@suggestion)
  end

  # DELETE /suggestions/1
  def destroy
    @suggestion = Suggestion.find(params[:id])
    flash[:notice] = t('suggestions.flash.destroy.notice') if @suggestion.destroy
    respond_with(@suggestion)
  end
  
  # Destroy all suggestions
  def clear_suggestions
    flash[:notice] = "Cleared all suggestions." if Suggestion.destroy_all
    redirect_to suggestions_url
  end
  
end
