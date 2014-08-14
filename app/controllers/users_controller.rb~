class UsersController < ApplicationController
  after_filter :include_role, only: :create
  layout 'application'
  
  def index
    @users = User.all
    
    respond_to do |format|
      format.html
      format.json { render json: @users }
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
