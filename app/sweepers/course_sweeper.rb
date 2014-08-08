class CourseSweeper < ActionController::Caching::Sweeper
  observe Course
  
  def after_create(course)
    expire_cache_for(course)
  end
  
  def after_update(course)
    expire_cache_for(course)
  end
  
  def after_destroy(course)
    expire_cache_for(course)
  end
  
  def expire_cache_for(course)
   # expire_page(:controller => 'courses', :action => 'index')
    
    expire_fragment('all_available_courses')
  end
end
