class Rest < ActiveResource::Base
  self.site = "http://redmine.railsware.com"
  self.user=("your_user_name")
  self.password=("your_password")
end
