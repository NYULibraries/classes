class ClassCategoriesController < ApplicationController
  before_filter :authenticate_admin
  respond_to :js, :html
    
  # GET /class_categories
  def index
    @class_categories = ClassCategory.find(:all) 
    respond_with(@class_categories)
  end

  # GET /class_categories/1
  def show
    @class_category = ClassCategory.find(params[:id])
    @class_sub_category = ClassSubCategory.new
    respond_with(@class_category)
  end

  # GET /class_categories/new
  def new
    @class_category = ClassCategory.new
    respond_with(@class_category)
  end
  
  # POST /class_categories
  def create
    @class_category = ClassCategory.new(params[:class_category])    
    flash[:notice] = t('class_categories.flash.create.notice') if @class_category.save
    respond_with(@class_category)
  end

  # GET /class_categories/1/edit
  def edit
    @class_category = ClassCategory.find(params[:id])
    respond_with(@class_category)
  end

  # PUT /class_categories/1
  def update
    @class_category = ClassCategory.find(params[:id])
    flash[:notice] = t('class_categories.flash.update.notice') if @class_category.update_attributes(params[:class_category])
    @class_categories = ClassCategory.all
    respond_with(@class_category)
  end

  # DELETE /class_categories/1
  def destroy
    @class_category = ClassCategory.find(params[:id])
    flash[:notice] = t('class_categories.flash.destroy.notice') if @class_category.destroy
    respond_with(@class_category)
  end
 
  # POST /class_categories/sort
  def sort
    @class_categories = ClassCategory.all

    params[:class_category].each_with_index do |id, index|
      ClassCategory.update_all(['position=?', index+1],['id=?',id])
    end 

    respond_with(@class_categories) do |format|
      format.js { render :nothing => true }
    end
  end
end
