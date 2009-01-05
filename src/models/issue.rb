class Issue < Rest

  def self.find_by_project_id(project_id)
    self.find(:all, :params => {:project_id => project_id})
  end
  
  def spent_hours
    @time_entries ||= Timelog.find_by_issue_id(self.id)
    @spent ||= @time_entries.blank? ? 0 : @time_entries.map(&:hours).sum(:hours)
  end
  
end
