class Recipe < ActiveRecord::Base
    attr_accessible :image, :information, :name, :preparation_method, :start_cooking_time, :start_preparation_time, :end_cooking_time, :end_preparation_time, :serves
  validates :name, :uniqueness => { :message => "Name already taken"}
  validates :name, :presence => { :message => "This field is required" }
  validates :information, :name, :preparation_method, :presence => { :message => "This field is required" }
#  validates :start_preparation_time, :end_preparation_time, :start_cooking_time,
#    :end_cooking_time, :serves, numericality: { only_integer: true }
#  validate :start_time_less_than_end_time
 # validates_start_time :start_preparation_time

  resourcify

  has_and_belongs_to_many :dishes
#  belongs_to :recipeable, polymorphic: true
  belongs_to :user
  belongs_to :course
  has_many :ingredients, through: :main_ingredients
  has_and_belongs_to_many :occassions

  mount_uploader :image, ImageUploader

  def self.calculate_minutes(time, unit)
    if unit.eql?("hours")
      minutes = (time.to_i * 60)
    else
      minutes = time
    end
    minutes
  end

  def self.calculate_time(minutes)
   time = minutes.blank? ? 0 : (minutes / 60)
   time
  end

  def self.find_recipeable_name(recipeable)
    if recipeable.is_a?User
      return recipeable.email
    else
      return recipeable.name
    end
  end

  def self.set_preparation_time_and_timeunit(recipe)
    puts "=========== In model ================="
    preparation_time_and_timeunit = Hash.new
    # set preparation time and preparation time unit
    preparation_time_and_timeunit[:start_preparation_time] = recipe.start_preparation_time >= 60 ? self.calculate_time(recipe.start_preparation_time) : recipe.start_preparation_time
    preparation_time_and_timeunit[:end_preparation_time] = recipe.end_preparation_time >= 60 ? self.calculate_time(recipe.end_preparation_time) : recipe.end_preparation_time
    preparation_time_and_timeunit[:start_preparation_time_unit] = recipe.start_preparation_time >= 60 ? "hours" : "minutes"
    preparation_time_and_timeunit[:end_preparation_time_unit] = recipe.end_preparation_time >= 60 ? "hours" : "minutes"
    preparation_time_and_timeunit
  end

  def self.set_cooking_time_and_timeunit(recipe)
    # set cooking time and cooking time unit
    cooking_time_and_timeunit = Hash.new
    cooking_time_and_timeunit[:start_cooking_time] = recipe.start_cooking_time >= 60 ? self.calculate_time(recipe.start_cooking_time) : recipe.start_cooking_time
    cooking_time_and_timeunit[:end_cooking_time] = recipe.end_cooking_time >= 60 ? self.calculate_time(recipe.end_cooking_time) : recipe.end_cooking_time
    cooking_time_and_timeunit[:start_cooking_time_unit] = recipe.start_cooking_time >= 60 ? "hours" : "minutes"
    cooking_time_and_timeunit[:end_cooking_time_unit] = recipe.end_cooking_time >= 60 ? "hours" : "minutes"
    cooking_time_and_timeunit
  end

  def self.find_course(recipeable)
    recipeable if recipeable.class.name.eql?("Course")
  end
end
