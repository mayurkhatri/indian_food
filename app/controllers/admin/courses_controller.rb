class Admin::CoursesController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin'
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
    @course = Course.new
    
    respond_with(@course)
  end

  def show
    @course = Course.find(params[:id])
    
    respond_with(:admin, @course)
  end

  def edit
    @course = Course.find(params[:id])
    
    respond_with(:admin, @course)
  end

  def create
    @course = Course.new(params[:course])
    
    flash[:notice] = "Course was successfully created" if @course.save
    respond_with(:admin, @course)    
  end

  def update
    @course = Course.find(params[:id])
    
    flash[:notice] = "Course was updated successfully" if @course.update_attributes(params[:course])
    respond_with(:admin, @course)
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    
    respond_with(:admin, @course)
  end
end
