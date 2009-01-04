class Project < Rest

  def to_s
    name
  end
  
  def issues
    @issues ||= Issue.find_by_project_id(self.id)
  end
end