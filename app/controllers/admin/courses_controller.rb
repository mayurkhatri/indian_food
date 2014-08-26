class Admin::CoursesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_role
  load_and_authorize_resource
  layout 'admin'
  cache_sweeper :course_sweeper
  respond_to :html, :xml, :json

  def index
    @courses = Course.all
    if params[:forrecipes].eql?("true")
      render 'forrecipe_index'
    else
      respond_with(:admin, @courses)
    end
  end

  def new
    respond_with(:admin, @course)
  end

  def show
    respond_with(:admin, @course)
  end

  def edit
    respond_with(:admin, @course)
  end

  def create
    flash[:notice] = "Course was successfully created" if @course.save
    respond_with(:admin, @course)
  end

  def update
    flash[:notice] = "Course was updated successfully" if @course.update_attributes(params[:course])
    respond_with(:admin, @course)
  end

  def destroy
    @course.destroy
    respond_with(:admin, @course)
  end

  def email_recipe
    @user = User.first
    UserMailer.send_recipe(@user).deliver
  end
end
