require 'models/enumeration'

class TimeEntry < Rest
  self.collection_name = "timelog"

  def available_enumerations
    self.class.available_enumerations
  end

  def self.find_by_issue_id(id)
    self.find(:all, :params => { :issue_id => id})
  end

  def self.commit(opts = {})
    post(:edit, :time_entry => opts, :issue_id => opts[:issue_id])
  end

  def self.available_enumerations
    @enumerations ||= Enumeration.find_by_class(self)
  end

end
