class UsersController < ApplicationController
  before_filter :authenticate_admin
  respond_to :html, :csv
     
  #list users with sort and search options
  def index
    @users = User.search(params[:q]).sorted(params[:sort], "fullname ASC").page(params[:page]).per(30)
    respond_with(@users)
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

  # GET /users/new
  def new
    @user = User.new
    respond_with(@user)
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    respond_with(@user)
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    admin = (params[:user_attributes].nil?) ? false : (params[:user_attributes][:classes_admin] == "on") ? true : false
    @user.user_attributes = { :classes_admin => admin } unless @user == current_user
    flash[:notice] = t('users.flash.update.notice') if @user.save and @user.update_attributes(params[:user]) 
    respond_with(@user)
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:notice] = t("users.flash.destroy.notice") if @user.destroy 
    else
      flash[:error] = t("users.flash.destroy.error")
    end
    respond_with(@user)
  end

  # DELETE /users/destroy_registration/1
  def destroy_registration
    @registration = Registration.find(params[:id])
    @user = @registration.user
    flash[:notice] = t("registrations.flash.destroy.notice") if @registration.destroy
    respond_with(@registration, :location => @user)
  end
  
  # DELETE /users/destroy_all
  def clear_users
    flash[:notice] = "Cleared all inactive non-admin users." if User.non_admin.inactive.destroy_all
    redirect_to users_url
  end
  
end
