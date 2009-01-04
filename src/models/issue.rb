class Issue < Rest

  def self.find_by_project_id(project_id)
    self.find(:all, :params => {:project_id => project_id})
  end
  
  def spent_hours
    @time_entries ||= Timelog.find_by_issue_id(self.id)
    puts self.id
    @spent ||= @time_entries.map(&:hours).sum(:hours) || 0
  end
  
end
