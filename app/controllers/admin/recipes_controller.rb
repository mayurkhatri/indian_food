class Admin::RecipesController < ApplicationController
  before_filter :authenticate_user!
#  before_filter :check_role
  before_filter :set_time, :only => [:create, :update]
  before_filter :set_time_unit, :only => [:create, :update]
  before_filter :set_initial_values, :only => [:new]
  before_filter :find_recipeable, :only => [:index, :show, :new, :create, :edit, :update, :destroy]
  before_filter :build_new_recipe, :only => [:new]  # Override loading of resource in load_and_authorize_resource
  before_filter :build_recipe, :only => [:create]  # Override loading of resource in load_and_authorize_resource
  load_and_authorize_resource
  layout 'admin'

  respond_to :html, :xml, :json

  def index
    if @recipeable.blank?
      @recipes = Recipe.all
    else
      @recipes = @recipeable.recipes
      @recipeable_name = Recipe.find_recipeable_name(@recipeable)
    end
    respond_with(:admin, @recipeable, @recipes)
  end

  def show
#    @recipe = Recipe.find(params[:id])
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
    @course_name = params[:course_id].blank? ? "" : Course.find(params[:course_id]).name
    @course_id = params[:course_id].blank? ? "" : params[:course_id]
    respond_with(:admin, @recipe)
  end

  def edit
#    @recipe = Recipe.find(params[:id])
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
    flash[:notice] = "Recipe created successfully"  if @recipe.save
    respond_with(:admin, @recipeable, @recipe)
  end

  def update
 #   @recipe = Recipe.find(params[:id])
    unless params[:recipe_course].blank?
      @recipe.recipeable_id = params[:recipe_course]
    end
    flash[:notice] = "Recipe was updated successfully" if @recipe.update_attributes(params[:recipe])
    respond_with(:admin, @recipeable, @recipe)
  end

  def destroy
  #  @recipe = Recipe.find(params[:id])
    @recipe.destroy
    respond_with(:admin, @recipeable, @recipe)
  end

  private

  def find_recipeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @recipeable = $1.classify.constantize.find(value)
      end
    end
    nil
  end

  # Override loading of resource in load_and_authorize_resource for new
  def build_new_recipe
    @recipe = @recipeable.recipes.build
  end

  # Override loading of resource in load_and_authorize_resource for create
  def build_recipe
    @recipe = @recipeable.recipes.build(params[:recipe])
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
    @start_preparation_time, @start_cooking_time = "1", "1"
    @end_preparation_time, @end_cooking_time = "30", "30"
    @start_preparation_time_unit, @start_cooking_time_unit = "minutes", "minutes"
    @end_preparation_time_unit, @end_cooking_time_unit = "minutes", "minutes"
    @serves = "1"
  end

  def check_role
    if (!current_user.has_role? :admin) || (!current_user.has_role? :moderator)
      raise CanCan::AccessDenied
    end
  end
end
