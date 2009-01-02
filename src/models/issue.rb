class Issue < Rest
  
  def self.find_by_project_id(project_id)
    self.find(:all)
  end
end
