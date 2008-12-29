class ProjectIndex
  
  def initialize(parent, projects = [], onchoose = proc {})
    frame = TkFrame.new(parent) do
      pack 'fill' => 'both', 'expand' => 'true'
    end
    
    $project_names = TkVariable.new(projects)
    
    list_w = TkListbox.new(frame) do
      selectmode 'single'
      pack 'side' => 'right', 'fill' => 'both', 'expand' => 'true'
      listvariable $project_names
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
  
  def projects=(projects)
    $project_names.value = TkVariable.new(projects)
  end
  
  def projects
    $project_names.to_a
  end
end