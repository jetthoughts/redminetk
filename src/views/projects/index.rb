class ProjectIndex
  def initialize(parent, projects = {}, onchoose = proc {})
    frame = TkFrame.new(parent) do
      pack 'fill' => 'both', 'expand' => 'true'
    end
    
    list_w = TkListbox.new(frame) do
      selectmode 'single'
      pack 'side' => 'right', 'fill' => 'both', 'expand' => 'true'
      listvariable $project_names
    end

    list_w.bind("ButtonRelease-1") do
      projectname = list_w.get(*list_w.curselection)
      onchoose.call(projects[projectname])
    end
    
    projects.each{|k,v| list_w.insert("end", k)}

    scroll_bar = TkScrollbar.new(frame) do
      command proc{|*args| list_w.yview(*args)}
      pack 'side' => 'left', 'fill' => 'y'
    end
    list_w.yscrollcommand {|first,last| scroll_bar.set(first,last) }
    frame.pack
  end
end