class ClassSubCategoriesController < ApplicationController
  before_filter :authenticate_admin
  respond_to :html, :js

  # POST /class_sub_categories
  def create         
    @class_sub_category = ClassSubCategory.create(params[:class_sub_category])
    @class_category = @class_sub_category.class_category
    if @class_sub_category.save
      flash[:notice] = t('class_sub_categories.flash.create.notice')
    else
      flash[:error] = t('class_sub_categories.flash.create.error')
    end
    respond_with(@class_sub_category) do |format|
      format.html { redirect_to @class_category }
    end
  end

  # DELETE /class_sub_categories/1
  def destroy
    @class_sub_category = ClassSubCategory.find(params[:id])
    flash[:notice] = t('class_sub_categories.flash.destroy.notice') if @class_sub_category.destroy
    respond_with(@class_sub_category, :location => @class_sub_category.class_category)
  end  

  # GET /class_sub_categories/1/edit
  def edit
    @class_sub_category = ClassSubCategory.find(params[:id])
    @class_category = ClassCategory.find(@class_sub_category.class_category_id)
  end

  # PUT /class_sub_categories/1
  def update
    @class_sub_category = ClassSubCategory.find(params[:id])
    flash[:notice] = t('class_sub_categories.flash.update.notice') if @class_sub_category.update_attributes(params[:class_sub_category])
    @class_category = @class_sub_category.class_category
    respond_with(@class_sub_category, :location => @class_sub_category.class_category)
  end
  
  # POST /class_sub_categories/sort
  def sort
    @class_sub_categories = ClassSubCategory.all

    params[:class_sub_category].each_with_index do |id, index|
     ClassSubCategory.update_all(['position=?', index+1],['id=?',id])
    end 

    respond_with(@class_sub_categories) do |format|
     format.js { render :nothing => true }
    end
  end
end
