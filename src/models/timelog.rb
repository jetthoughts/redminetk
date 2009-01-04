class Timelog < Rest

  def self.find_by_issue_id(id)
    self.find(:all, :params => { :issue_id => id})
  end
  
  def self.collection_name
    "timelog"
  end
  
  def collection_name
    "timelog"
  end 
end