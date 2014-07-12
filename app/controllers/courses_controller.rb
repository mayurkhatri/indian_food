class CoursesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @courses = Course.all
    
    respond_to do |format|
      format.html
      format.json{ render json: @courses }
    end
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
