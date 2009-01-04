class IssueShow < TkLabelFrame

  def initialize(*args)
    super(*args)
    text "Issue \#-"
    ui
  end

  def issue=(issue)
    text "Issue \##{issue.id}"
    $assignees.value = TkVariable.new(show_users(issue.assigned_to_users) || "--")
    $estimate.value = TkVariable.new("#{issue.estimated_hours} hour(s)" || "--")
    $description.value = TkVariable.new(issue.description || "--")
    $spent.value = TkVariable.new(issue.spent_hours || "--" )
  end

  private
  def ui
    $assignees = TkVariable.new("none")
    $estimate = TkVariable.new("none")
    $description = TkVariable.new("none")
    $spent = TkVariable.new("none")
    
    raw = TkFrame.new(self) do
      pack :side => "top", :fill => "x"
    end
    
    TkLabel.new(raw) do
      text "Assigned to:"
      pack :side => "left"
    end

    TkLabel.new(raw) do
      textvariable $assignees
      pack :side => "left"
    end
    
    raw = TkFrame.new(self) do
      pack :side => "top", :fill => "x"
    end
    
    TkLabel.new(raw) do
      text "Spent:"
      pack :side => "left"
    end

    TkLabel.new(raw) do
      textvariable $spent
      pack :side => "left"
    end
    
    raw = TkFrame.new(self) do
      pack :side => "top", :fill => "x"
    end
    
    TkLabel.new(raw) do
      text "Estimate:"
      pack :side => "left"
    end

    TkLabel.new(raw) do
      textvariable $estimate
      pack :side => "left"
    end
    
    raw = TkFrame.new(self) do
      pack :side => "top", :fill => "x"
    end
    
    TkLabel.new(raw) do
      text "Description:"
      pack :side => "left"
    end

    TkLabel.new(raw) do
      textvariable $description
      pack :side => "left"
    end
  end

end