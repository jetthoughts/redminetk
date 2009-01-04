class ProjectIndex < TkFrame
  def initialize(*args)
    super(*args)
    config
  end
  
  def config(projects = [], onchange = proc{|*args| true })
    frame = self
    
    $project_names = TkVariable.new(projects)
    @onchange = onchange
    
    list_w = TkListbox.new(frame) do
      selectmode 'single'
      pack 'side' => 'right', 'fill' => 'both', 'expand' => 'true'
      listvariable $project_names
      relief "flat"
    end

    list_w.bind("ButtonRelease-1") do
      @onchange.call(list_w.get(*list_w.curselection)) unless list_w.curselection.blank?
    end
    
    scroll_bar = TkScrollbar.new(frame) do
      command proc{|*args| list_w.yview(*args)}
      width 10
      relief "flat"
      pack 'side' => 'left', 'fill' => 'y'
    end
    list_w.yscrollcommand {|first,last| scroll_bar.set(first,last) }
  end
  
  def projects=(projects)
    $project_names.value = TkVariable.new(projects)
  end
  
  def projects
    $project_names.to_a
  end
  
  def onchange=(onchange = proc{|*args|true})
    @onchange = onchange
  end
end