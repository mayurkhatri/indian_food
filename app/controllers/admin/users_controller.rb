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

  def new
    
  end
  
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.'}
        format.json { render json: @user, status: :created, location: @user }
      else
	format.html { render action: "new" }
	format.json { render json: @user.errors, status: :unprocessable_entity }      
      end
    end
  end
  
  def include_role
    @user = User.last
    @user.add_role :site_user
  end
end
