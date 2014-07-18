class RecipesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_time, :only => [:create, :update]
  before_filter :set_time_unit, :only => [:create, :update]
  
  respond_to :html, :xml, :json
  
  def index
    @recipeable = find_recipeable	
    unless @recipeable.blank?
      @recipes = @recipeable.recipes
    end
    if @recipeable.blank?
      @recipes = Recipe.all
    end
     
    respond_with(@recipeable, @recipes)
  end
  
  def show
    @recipeable = find_recipeable
    @recipe = Recipe.find(params[:id])
    @course = @recipe.recipeable if @recipe.recipeable.class.name.eql?("Course")

    @start_preparation_time = @recipe.start_preparation_time >= 60 ? Recipe.calculate_time(@recipe.start_preparation_time) : @recipe.start_preparation_time
    @end_preparation_time = @recipe.end_preparation_time >= 60 ? Recipe.calculate_time(@recipe.end_preparation_time) : @recipe.end_preparation_time
    @start_preparation_time_unit = @recipe.start_preparation_time >= 60 ? "hours" : "minutes"
    @end_preparation_time_unit = @recipe.end_preparation_time >= 60 ? "hours" : "minutes"
    
    @start_cooking_time = @recipe.start_cooking_time >= 60 ? Recipe.calculate_time(@recipe.start_cooking_time) : @recipe.start_cooking_time
    @end_cooking_time = @recipe.end_cooking_time >= 60 ? Recipe.calculate_time(@recipe.end_cooking_time) : @recipe.end_cooking_time
    @start_cooking_time_unit = @recipe.start_cooking_time >= 60 ? "hours" : "minutes"
    @end_cooking_time_unit = @recipe.end_cooking_time >= 60 ? "hours" : "minutes"
    
    @serves = @recipe.serves
    
    respond_with(@recipe)
  end
  
  def new
    @recipeable = find_recipeable
    @recipe = @recipeable.recipes.build
    debugger
    @course_name = params[:course_id].blank? ? "" : Course.find(params[:course_id]).name
    @courses = Course.all
    
    @start_preparation_time, @start_cooking_time = "1", "1"
    @end_preparation_time, @end_cooking_time = "30", "30"
    @start_preparation_time_unit, @start_cooking_time_unit = "minutes", "minutes"
    @end_preparation_time_unit, @end_cooking_time_unit = "minutes", "minutes"
    @serves = "1"
    
    respond_with(@recipe)
  end
  
  def edit
    @recipeable = find_recipeable
    @recipe = Recipe.find(params[:id])
    @course = @recipe.recipeable if @recipe.recipeable.class.name.eql?("Course")
    @courses = Course.all
    
    @start_preparation_time = @recipe.start_preparation_time >= 60 ? Recipe.calculate_time(@recipe.start_preparation_time) : @recipe.start_preparation_time
    @end_preparation_time = @recipe.end_preparation_time >= 60 ? Recipe.calculate_time(@recipe.end_preparation_time) : @recipe.end_preparation_time
    @start_preparation_time_unit = @recipe.start_preparation_time >= 60 ? "hours" : "minutes"
    @end_preparation_time_unit = @recipe.end_preparation_time >= 60 ? "hours" : "minutes"
    
    @start_cooking_time = @recipe.start_cooking_time >= 60 ? Recipe.calculate_time(@recipe.start_cooking_time) : @recipe.start_cooking_time
    @end_cooking_time = @recipe.end_cooking_time >= 60 ? Recipe.calculate_time(@recipe.end_cooking_time) : @recipe.end_cooking_time
    @start_cooking_time_unit = @recipe.start_cooking_time >= 60 ? "hours" : "minutes"
    @end_cooking_time_unit = @recipe.end_cooking_time >= 60 ? "hours" : "minutes"
    
    @serves = @recipe.serves
    
    respond_with(@recipe)
  end
  
  def create
    @recipeable = find_recipeable
    @recipe = @recipeable.recipes.build(params[:recipe])
    
    @recipe.start_preparation_time = Recipe.calculate_minutes(params[:start_preparation_time], params[:start_preparation_time_unit])
    @recipe.end_preparation_time = Recipe.calculate_minutes(params[:end_preparation_time], params[:end_preparation_time_unit])
    
    @recipe.start_cooking_time = Recipe.calculate_minutes(params[:start_cooking_time], params[:start_cooking_time_unit])
    @recipe.end_cooking_time = Recipe.calculate_minutes(params[:end_cooking_time], params[:end_cooking_time_unit])
    @recipe.serves = params[:serves]
    
    flash[:notice] = "Recipe created successfully"  if @recipe.save
    respond_with(@recipeable)
  end
  
  def update
    @recipeable = find_recipeable
    @recipe = Recipe.find(params[:id])
    @recipe.start_preparation_time = Recipe.calculate_minutes(params[:start_preparation_time], params[:start_preparation_time_unit])
    @recipe.end_preparation_time = Recipe.calculate_minutes(params[:end_preparation_time], params[:end_preparation_time_unit])
    
    @recipe.start_cooking_time = Recipe.calculate_minutes(params[:start_cooking_time], params[:start_cooking_time_unit])
    @recipe.end_cooking_time = Recipe.calculate_minutes(params[:end_cooking_time], params[:end_cooking_time_unit])
    @recipe.serves = params[:serves]
    
    flash[:notice] = "Recipe was updated successfully" if Recipe.update_attributes(@recipe)
    respond_with(@recipeable, @recipe)
  end
  
  def destroy
    @recipeable = find_recipeable
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    
    respond_with(@recipeable, @recipe)
  end
  
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
end
