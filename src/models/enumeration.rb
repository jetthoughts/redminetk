require 'models/time_entry'
require 'models/issue'

class Enumeration < Rest
  OPTIONS = {
    TimeEntry => "ACTI",
    Issue => "IPRI"
  }

  def self.find_by_class(class_instance)
    find(:all, :params => {:opt => Enumeration::OPTIONS[class_instance]})
  end

  def to_s
    self.name
  end
end
