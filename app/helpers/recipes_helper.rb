module RecipesHelper
  protected 
  def all_courses
    courses = Course.all.each.map { |course| course.name }
    course_ids = Course.all.each.map { |course| course.id}
    options_for_select(courses.zip(course_ids), @course_id)
  end
  
  def start_preparation_time_unit
    options_for_select([["minutes", "minutes"], ["hours", "hours"]], @start_preparation_time_unit)
  end
  
  def end_preparation_time_unit
    options_for_select([["minutes", "minutes"], ["hours", "hours"]], @end_preparation_time_unit)
  end
  
  def start_preparation_time
    if @start_preparation_time_unit.eql?("minutes")
      time_values = (1..55).select do |i| i%5 == 0 end
    elsif @start_preparation_time_unit.eql?("hours")
      time_values = (1..10)      
    end
    options_for_select(time_values.zip(time_values), @start_preparation_time)
  end
  
  def end_preparation_time
    if @end_preparation_time_unit.eql?("minutes")
      time_values = (1..55).select do |i| i%5 == 0 end
    elsif @end_preparation_time_unit.eql?("hours") 
      time_values = (1..10)
    end
    options_for_select(time_values.zip(time_values), @end_preparation_time)
  end
  
  def start_cooking_time_unit
    options_for_select([["minutes", "minutes"], ["hours", "hours"]], @start_cooking_time_unit)
  end
  
  def end_cooking_time_unit
    options_for_select([["minutes", "minutes"], ["hours", "hours"]], @end_cooking_time_unit)
  end
  
  def start_cooking_time
    if @start_cooking_time_unit.eql?("minutes")
      time_values = (0..55).select do |i| i%5 == 0 end
    elsif @start_cooking_time_unit.eql?("hours")
      time_values = (0..10)
    end
    options_for_select(time_values.zip(time_values), @start_cooking_time)
  end
  
  def end_cooking_time
    if @end_cooking_time_unit.eql?("minutes")
      time_values = (0..55).select do |i| i%5 == 0 end
    elsif @end_cooking_time_unit.eql?("hours")
      time_values = (0..10)
    end
    options_for_select(time_values.zip(time_values), @end_cooking_time)
  end
  
  def serves
    serving = [*1..20]
    options_for_select(serving, @serves)
  end
  
  def insert_break(input_string)
    unless input_string.blank?
      input_string.gsub("\n", "<br/>").html_safe
    end
  end
end
