module RecipesHelper
  protected 
  def hours
    options_for_select([["1", "1"], ["2", "2"]], @hours)
  end
   
  def minutes
    options_for_select([["1", "1"], ["2", "2"], ["3", "3"]], @minutes)
  end
end
