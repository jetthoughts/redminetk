class Project < Rest
  def to_s
    name
  end
  
  def issues
    get(:issues).map{|i| Issue.new(i)}
  end
end