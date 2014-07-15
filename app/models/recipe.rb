class Recipe < ActiveRecord::Base
    attr_accessible :image, :information, :name, :preparation_method, :start_cooking_time, :start_preparation_time, :end_cooking_time, :end_preparation_time, :serves
  validates :name, :uniqueness => { :message => "Name already taken"}
  validates :name, :presence => { :message => "This field is required" }
  validates :information, :name, :preparation_method, :presence => { :message => "This field is required" }
  validates :start_preparation_time, :end_preparation_time, :start_cooking_time,
    :end_cooking_time, :serves, numericality: { only_integer: true }
#  validate :start_time_less_than_end_time
  validates_start_time :start_preparation_time
  
  resourcify
  
  has_and_belongs_to_many :dishes
  belongs_to :recipeable, polymorphic: true
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
  
  def name
    "#{Course.name.first}"
  end

  
  private
  
  def start_time_less_than_end_time
    errors.add(:start_cooking_time, "should be less than end cooking time") if start_cooking_time >= end_cooking_time
    errors.add(:start_preparation_time, "should be less than end preparation time") if start_preparation_time >= end_preparation_time
  end
  
end
