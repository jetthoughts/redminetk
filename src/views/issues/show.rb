class IssueShow < TkLabelFrame

  def initialize(*args)
    super(*args)
    text "Issue \#-"
    ui
  end

  def issue=(issue)
    text "Issue \##{issue.id}"
    $assignees.value = TkVariable.new(show_users(issue.assigned_to_users))
    $estimate.value = TkVariable.new(show_content(issue.estimated_hours))
    $description.value = TkVariable.new(show_content(issue.description))
    $status.value = TkVariable.new(show_content(issue.status.name))
    $spent.value = TkVariable.new(issue.spent_hours > 0 ? show_content(issue.spent_hours) : "--")
  end

  private
  def ui
    $assignees = TkVariable.new("none")
    $estimate = TkVariable.new("none")
    $description = TkVariable.new("none")
    $spent = TkVariable.new("none")
    $status = TkVariable.new("none")
    
    info = [
      $description, "Description:",
      $status, "Status:",
      $assignees, "Assigned to:",
      $spent, "Spent:",
      $estimate, "Estimate:"]
      
    
    i = 0; len = info.size
    while(i < len)
        raw = TkFrame.new(self){pack :side => "top", :fill => "x"}
      
        TkLabel.new(raw) do
          text info[i+1]
          pack :side => "left"
        end
      
        TkLabel.new(raw) do
          textvariable info[i]
          pack :side => "left"
        end
        i += 2
    end
  end
end