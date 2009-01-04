class IssueShow < TkLabelFrame
  
  def initialize(*args)
    super(*args)
    text "Issue Info:"
    ui
  end
  
  def issue=(issue)
    $variable.value = TkVariable.new(issue.id)
  end
  
  private
  def ui
    $variable = TkVariable.new("none")
    TkLabel.new(self) do
      textvariable $variable
      pack :padx => 10, :pady => 10
    end
  end
  
end