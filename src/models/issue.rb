class Issue < Rest

  def self.find_by_project_id(project_id)
    self.find(:all, :params => {:project_id => project_id})
  end
  
  def time_entries
    @time_entries ||= Timelog.find_by_issue_id(self.id)
  end
  
  def spent_hours
    @spent ||= time_entries.blank? ? 0 : time_entries.sum(:hours)
  end
  
end
