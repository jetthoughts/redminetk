class IssueIndex
  
  def initialize(parent)
    frame = TkFrame.new(parent) do
      pack 'fill' => 'both', 'expand' => 'true'
    end
    
    $issues = TkVariable.new([".."])
    
    list_w = TkListbox.new(frame) do
      selectmode 'single'
      pack 'side' => 'right', 'fill' => 'both', 'expand' => 'true'
      listvariable $issues
    end

    list_w.bind("ButtonRelease-1") do
      onchoose.call(list_w.get(*list_w.curselection))
    end
    
    scroll_bar = TkScrollbar.new(frame) do
      command proc{|*args| list_w.yview(*args)}
      pack 'side' => 'left', 'fill' => 'y'
    end
    list_w.yscrollcommand {|first,last| scroll_bar.set(first,last) }
    frame.pack
  end
  
  def issues=(issues)
    $issues.value = TkVariable.new(issues)
  end
  
  def issues
    $issues.to_a
  end
end