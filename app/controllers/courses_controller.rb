class CoursesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :json
  
  def index
    @courses = Course.all
    
    if params[:forrecipes].eql?("true")
      render 'forrecipe_index'
    else
      respond_with @courses
    end
  end

  def new
    @course = Course.new
    
    respond_with(@course)
  end

  def show
    @course = Course.find(params[:id])
    
    respond_with(@course)
  end

  def edit
    @course = Course.find(params[:id])
    
    respond_with(@course)
  end

  def create
    @course = Course.new(params[:course])
    
    flash[:notice] = "Course was successfully created" if @course.save
    respond_with(@course)    
  end

  def update
    @course = Course.find(params[:id])
    
    flash[:notice] = "Course was updated successfully" if Course.update_attributes(@course)
    respond_with(@course)
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    
    respond_with(@course)
  end
end
