class RecipesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @recipes = Recipe.all
    
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end
  
  def show
    @recipe = Recipe.find(params[:id])

    @start_preparation_time = @recipe.start_preparation_time >= 60 ? Recipe.calculate_time(@recipe.start_preparation_time) : @recipe.start_preparation_time
    @end_preparation_time = @recipe.end_preparation_time >= 60 ? Recipe.calculate_time(@recipe.end_preparation_time) : @recipe.end_preparation_time
    @start_preparation_time_unit = @recipe.start_preparation_time >= 60 ? "hours" : "minutes"
    @end_preparation_time_unit = @recipe.end_preparation_time >= 60 ? "hours" : "minutes"
    
    @start_cooking_time = @recipe.start_cooking_time >= 60 ? Recipe.calculate_time(@recipe.start_cooking_time) : @recipe.start_cooking_time
    @end_cooking_time = @recipe.end_cooking_time >= 60 ? Recipe.calculate_time(@recipe.end_cooking_time) : @recipe.end_cooking_time
    @start_cooking_time_unit = @recipe.start_cooking_time >= 60 ? "hours" : "minutes"
    @end_cooking_time_unit = @recipe.end_cooking_time >= 60 ? "hours" : "minutes"
    
    @serves = @recipe.serves
    
    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end
  
  def new
    @recipe = Recipe.new
    
    @start_preparation_time, @start_cooking_time = "1", "1"
    @end_preparation_time, @end_cooking_time = "30", "30"
    @start_preparation_time_unit, @start_cooking_time_unit = "minutes", "minutes"
    @end_preparation_time_unit, @end_cooking_time_unit = "minutes", "minutes"
    @serves = "1"
    
    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
    
    @start_preparation_time = @recipe.start_preparation_time >= 60 ? Recipe.calculate_time(@recipe.start_preparation_time) : @recipe.start_preparation_time
    @end_preparation_time = @recipe.end_preparation_time >= 60 ? Recipe.calculate_time(@recipe.end_preparation_time) : @recipe.end_preparation_time
    @start_preparation_time_unit = @recipe.start_preparation_time >= 60 ? "hours" : "minutes"
    @end_preparation_time_unit = @recipe.end_preparation_time >= 60 ? "hours" : "minutes"
    
    @start_cooking_time = @recipe.start_cooking_time >= 60 ? Recipe.calculate_time(@recipe.start_cooking_time) : @recipe.start_cooking_time
    @end_cooking_time = @recipe.end_cooking_time >= 60 ? Recipe.calculate_time(@recipe.end_cooking_time) : @recipe.end_cooking_time
    @start_cooking_time_unit = @recipe.start_cooking_time >= 60 ? "hours" : "minutes"
    @end_cooking_time_unit = @recipe.end_cooking_time >= 60 ? "hours" : "minutes"
    
    @serves = @recipe.serves
  end
  
  def create
  
#    debugger
    @recipe = Recipe.new(params[:recipe])
    
    @recipe.start_preparation_time = Recipe.calculate_minutes(params[:start_preparation_time], params[:start_preparation_time_unit])
    @recipe.end_preparation_time = Recipe.calculate_minutes(params[:end_preparation_time], params[:end_preparation_time_unit])
    
    @recipe.start_cooking_time = Recipe.calculate_minutes(params[:start_cooking_time], params[:start_cooking_time_unit])
    @recipe.end_cooking_time = Recipe.calculate_minutes(params[:end_cooking_time], params[:end_cooking_time_unit])
    @recipe.serves = params[:serves]

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html { render action: "new"}
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end  
    end
  end
  
  def update
    debugger
    @recipe = Recipe.find(params[:id])
    @recipe.start_preparation_time = Recipe.calculate_minutes(params[:start_preparation_time], params[:start_preparation_time_unit])
    @recipe.end_preparation_time = Recipe.calculate_minutes(params[:end_preparation_time], params[:end_preparation_time_unit])
    
    @recipe.start_cooking_time = Recipe.calculate_minutes(params[:start_cooking_time], params[:start_cooking_time_unit])
    @recipe.end_cooking_time = Recipe.calculate_minutes(params[:end_cooking_time], params[:end_cooking_time_unit])
    @recipe.serves = params[:serves]
    
    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }  
      end
    end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end
end
