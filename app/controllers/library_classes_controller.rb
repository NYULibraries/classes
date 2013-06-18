class LibraryClassesController < ApplicationController
  before_filter :authenticate_admin
  respond_to :js, :html, :json
  
  # GET /library_classes
  def index
    @library_classes = LibraryClass.all
    @class_categories = ClassCategory.all
    respond_with(@library_classes)
  end

  # GET /library_classes/1
  def show
    @library_class = LibraryClass.find(params[:id])
    @class_date = ClassDate.new(params[:class_date])
    respond_with(@library_class)
  end
  
  # GET /library_classes/new
  def new
    @library_class = LibraryClass.new
    @class_categories = ClassCategory.all
    @class_sub_categories = []
    respond_with(@library_class)
  end

  # GET /library_classes/1/edit
  def edit
    @library_class = LibraryClass.find(params[:id])
    @class_categories = ClassCategory.all
    @class_sub_categories = @library_class.class_category.class_sub_categories
    respond_with(@library_class)
  end

  # POST /library_classes
  def create
    @library_class = LibraryClass.new(params[:library_class])
    @class_categories = ClassCategory.all
    @class_category = ClassCategory.find(params[:library_class][:class_category_id]) unless params[:library_class][:class_category_id].blank?
    @class_sub_categories = (@class_category.nil?) ? [] : @class_category.class_sub_categories
    flash[:notice] = t('library_classes.flash.create.notice') if @library_class.save
    respond_with(@library_class)
  end
  
  # PUT /library_classes/1
  def update
    @library_class = LibraryClass.find(params[:id])
    flash[:notice] = t('library_classes.flash.update.notice') if @library_class.update_attributes(params[:library_class])
    @class_categories = ClassCategory.all
    @class_sub_categories = ClassSubCategory.find_all_by_class_category_id(@library_class.class_category_id)
    respond_with(@library_class)
  end

  # DELETE /library_classes/1
  def destroy
    @library_class = LibraryClass.find(params[:id])
    @library_class.destroy
    respond_with(@library_class)
  end
      
  # POST /library_classes/sort
  def sort
    @library_classes = LibraryClass.all

    params[:library_class].each_with_index do |id, index|
      LibraryClass.update_all(['position=?', index+1],['id=?',id])
    end 

    respond_with(@library_classes) do |format|
      format.js { render :nothing => true }
    end
  end

end
