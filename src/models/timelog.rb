class TimeEntry < Rest

  def self.find_by_issue_id(id)
    self.find(:all, :params => { :issue_id => id})
  end
  
  def self.collection_name
    "timelog"
  end
  
  def collection_name
    "timelog"
  end
  
  def self.commit(issue_id, time_entry = {})
    post(:edit, :time_entry => time_entry, :issue_id => issue_id )
  end
end