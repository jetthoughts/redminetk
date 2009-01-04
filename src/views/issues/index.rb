class IssueIndex < TkFrame
  
  def initialize(*args)
    super(*args)
    config
  end
  
  def config
    frame = self
    $issues = TkVariable.new([".."])
    
    list_w = TkListbox.new(frame) do
      selectmode 'single'
      pack 'side' => 'right', 'fill' => 'both', 'expand' => 'true'
      relief "flat"
      listvariable $issues
    end
    
    scroll_bar = TkScrollbar.new(frame) do
      command proc{|*args| list_w.yview(*args)}
      width 10
      relief "flat"
      pack 'side' => 'left', 'fill' => 'y'
    end
    list_w.yscrollcommand {|first,last| scroll_bar.set(first,last) }
  end
  
  def issues=(issues)
    $issues.value = TkVariable.new(issues)
  end
  
  def issues
    $issues.to_a
  end
end