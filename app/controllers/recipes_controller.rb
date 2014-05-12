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
    arr_time = []
    arr_time = Recipe.calculate_time(@recipe.preparation_time)
    @hours = arr_time[0]
    @minutes = arr_time[1]
    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end
  
  def new
    @recipe = Recipe.new
    @hours = 0
    @minutes = 1
    
    respond_to do |format|
      format.html
      format.json { resnder json: @recipe }
    end
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.preparation_time = Recipe.calculate_minutes(params[:select_hours], params[:select_minutes])
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
    @recipe = Recipe.find(params[:id])
    
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
