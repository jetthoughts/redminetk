class Issue < Rest
  
  def self.find_by_project_id(project_id)
    self.find(:all, :params => {:project_id => project_id})
  end
end
