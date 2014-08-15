class Admin::UsersController < ApplicationController
  after_filter :include_role, only: :create
  layout 'admin'
  respond_to :html, :xml, :json

  def index
    @users = User.all

    if params[:forrecipes].eql?("true")
      render 'forrecipe_index'
    else
      respond_with(:admin, @users)
    end
  end

  def show
    @user = User.find(params[:id])
    respond_with(:admin, @user)
  end

  def new
    @user = User.new
    respond_with(:admin, @user)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User successfully created."
    end
    respond_with(:admin, @user)
  end


  def edit
    @user = User.find(@user)
    respond_with(:admin, @user)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully update user."
    end
    respond_with(:admin, @user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully deleted user."
    respond_with(:admin, @user)
  end

  def include_role
    @user = User.last
    @user.add_role :site_user
  end
end
