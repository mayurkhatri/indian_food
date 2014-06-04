module RecipesHelper
  protected 
  def start_preparation_time_unit
    options_for_select([["minutes", "minutes"], ["hours", "hours"]], @start_preparation_time_unit)
  end
  
  def end_preparation_time_unit
    options_for_select([["minutes", "minutes"], ["hours", "hours"]], @end_preparation_time_unit)
  end
  
  def start_preparation_time
    minutes = [*1..59]
    options_for_select(minutes.zip(minutes), @start_preparation_time)
  end
  
  def end_preparation_time
    minutes = [*1..59]
    options_for_select(minutes.zip(minutes), @end_preparation_time)
  end
  
  def start_cooking_time_unit
    options_for_select([["minutes", "minutes"], ["hours", "hours"]], @start_cooking_time_unit)
  end
  
  def end_cooking_time_unit
    options_for_select([["minutes", "minutes"], ["hours", "hours"]], @end_cooking_time_unit)
  end
  
  def start_cooking_time
    minutes = [*1..59]
    options_for_select(minutes.zip(minutes), @start_cooking_time)
  end
  
  def end_cooking_time
    minutes = [*1..59]
    options_for_select(minutes.zip(minutes), @end_cooking_time)
  end
  
  def insert_break(input_string)
    unless input_string.blank?
      input_string.gsub("\n", "<br/>").html_safe
    end
  end
end
