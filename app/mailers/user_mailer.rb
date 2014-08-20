class UserMailer < ActionMailer::Base
  default from: "mayurkhatri122@gmail.com"
  def send_recipe(user)
    mail(:to=> "mayurkhatri122@gmail.com", :subject => "Recipe", :from => "mayurkhatri122@gmail.com")
  end
end
