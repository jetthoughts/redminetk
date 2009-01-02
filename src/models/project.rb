class Project < Rest

  def to_s
    name
  end
  
  def issues
    Issues.find_by_project_id(self.id)
    get(:issues).map{|i| Issue.new(i)}
  end
end