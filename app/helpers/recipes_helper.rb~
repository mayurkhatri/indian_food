module RecipesHelper
  protected 
  def preparation_hours
    options_for_select([["1", "1"], ["2", "2"]], @preparation_hours)
  end
   
  def preparation_minutes
    options_for_select([["1", "1"], ["2", "2"], ["3", "3"]], @preparation_minutes)
  end
  
  def cooking_hours
    options_for_select([["1", "1"], ["2", "2"]], "1")
  end
  
  def cooking_minutes
    options_for_select([["1", "1"], ["2", "2"]], "1")
  end
  
  def insert_break(input_string)
    unless input_string.blank?
      input_string.gsub("\n", "<br/>")
    end
  end
end
