class Admin::RecipesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_time, :only => [:create, :update]
  before_filter :set_time_unit, :only => [:create, :update]
#  before_filter :set_initial_values, :only => [:new]
  layout 'admin'
  
  respond_to :html, :xml, :json
  
  def index
    @recipeable = find_recipeable	
    if @recipeable.blank?
      @recipes = Recipe.all
    else
      @recipes = @recipeable.recipes
      @recipeable_name = Recipe.find_recipeable_name(@recipeable)
    end
    respond_with(:admin, @recipeable, @recipes)
  end
  
  def show
    @recipeable = find_recipeable
    @recipe = Recipe.find(params[:id])
    recipe = @recipe
    @course = Recipe.find_course(@recipeable)
    preparation_time_and_timeunit = Recipe.set_preparation_time_and_timeunit(recipe)
    set_preparation_time_and_timeunit(preparation_time_and_timeunit)
    cooking_time_and_timeunit = Recipe.set_cooking_time_and_timeunit(recipe)
    set_cooking_time_and_timeunit(cooking_time_and_timeunit) 
    @serves = @recipe.serves
    
    respond_with(:admin, @recipe)
  end
  
  def new
    @recipeable = find_recipeable
    @recipe = @recipeable.recipes.build
    @course_name = params[:course_id].blank? ? "" : Course.find(params[:course_id]).name
    @course_id = params[:course_id].blank? ? "" : params[:course_id]
    debugger
    respond_with(:admin, @recipe)
  end
  
  def edit
    @recipeable = find_recipeable
    @recipe = Recipe.find(params[:id])
    recipe = @recipe
    @course = Recipe.find_course(@recipeable)
    @course_id = params[:course_id].blank? ? "" : params[:course_id]
    preparation_time_and_timeunit = Recipe.set_preparation_time_and_timeunit(recipe)
    set_preparation_time_and_timeunit(preparation_time_and_timeunit)
    cooking_time_and_timeunit = Recipe.set_cooking_time_and_timeunit(recipe)
    set_cooking_time_and_timeunit(cooking_time_and_timeunit)
    @serves = recipe.serves

    respond_with(:admin, @recipe)
  end
  
  def create
    @recipeable = find_recipeable
    @recipe = @recipeable.recipes.build(params[:recipe])
    
    calculate_start_and_end_time    
    params[:recipe][:serves] = params[:serves]
    
    flash[:notice] = "Recipe created successfully"  if @recipe.save
    respond_with(:admin, @recipeable, @recipe)
  end
  
  def update
    @recipeable = find_recipeable
    @recipe = Recipe.find(params[:id])
    unless params[:recipe_course].blank?
      @recipe.recipeable_id = params[:recipe_course]
    end
    calculate_start_and_end_time
    params[:recipe][:serves] = params[:serves]
    flash[:notice] = "Recipe was updated successfully" if @recipe.update_attributes(params[:recipe])
    respond_with(:admin, @recipeable, @recipe)
  end
  
  def destroy
    @recipeable = find_recipeable
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    
    respond_with(:admin, @recipeable, @recipe)
  end
  
  private
  
  def set_time
    @start_preparation_time = params[:start_preparation_time]
    @end_preparation_time = params[:end_preparation_time]
    @start_cooking_time = params[:start_cooking_time]
    @end_cooking_time = params[:end_cooking_time]
  end
  
  def set_time_unit
    @start_preparation_time_unit = params[:start_preparation_time_unit]
    @end_preparation_time_unit = params[:end_preparation_time_unit]
    @start_cooking_time_unit = params[:start_cooking_time_unit]
    @end_cooking_time_unit = params[:end_cooking_time_unit]
  end
  
  def find_recipeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
  def calculate_start_and_end_time
    params[:recipe][:start_preparation_time] = Recipe.calculate_minutes(params[:start_preparation_time], params[:start_preparation_time_unit])
    params[:recipe][:end_preparation_time] = Recipe.calculate_minutes(params[:end_preparation_time], params[:end_preparation_time_unit])
    
    params[:recipe][:start_cooking_time] = Recipe.calculate_minutes(params[:start_cooking_time], params[:start_cooking_time_unit])
    params[:recipe][:end_cooking_time] = Recipe.calculate_minutes(params[:end_cooking_time], params[:end_cooking_time_unit])
  end
  
  def set_preparation_time_and_timeunit(preparation_time_and_timeunit)
    @start_preparation_time = preparation_time_and_timeunit[:start_preparation_time]
    @end_preparation_time = preparation_time_and_timeunit[:end_preparation_time]
    @start_preparation_time_unit = preparation_time_and_timeunit[:start_preparation_time_unit]
    @end_preparation_time_unit = preparation_time_and_timeunit[:end_preparation_time_unit]
  end
  
  def set_cooking_time_and_timeunit(cooking_time_and_timeunit)
    @start_cooking_time = cooking_time_and_timeunit[:start_cooking_time]
    @end_cooking_time = cooking_time_and_timeunit[:end_cooking_time]
    @start_cooking_time_unit = cooking_time_and_timeunit[:start_cooking_time_unit]
    @end_cooking_time_unit = cooking_time_and_timeunit[:end_cooking_time_unit]
  end
  
  def set_initial_values
    debugger
    @start_preparation_time, @start_cooking_time = "1", "1"
    @end_preparation_time, @end_cooking_time = "30", "30"
    @start_preparation_time_unit, @start_cooking_time_unit = "minutes", "minutes"
    @end_preparation_time_unit, @end_cooking_time_unit = "minutes", "minutes"
    @serves = "1"
  end
end
