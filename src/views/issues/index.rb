class IssueIndex < TkLabelFrame

  def initialize(*args)
    super(*args)
    config
    text "Issues:"
  end
  
  def issues=(issues)
    $issues.value = TkVariable.new(issues)
  end

  def issues
    $issues.to_a
  end
  
  def onchange=(onchange = proc{|*args| true})
    @onchange = onchange if onchange.is_a?(Proc)
  end

  private
  def config
    $issues = TkVariable.new([])
    @onchange = proc{|*args| true }

    list_w = TkListbox.new(self) do
      selectmode 'single'
      pack 'side' => 'right', 'fill' => 'both', 'expand' => 'true'
      relief "flat"
      listvariable $issues
    end

    list_w.bind("ButtonRelease-1") do
      @onchange.call(*list_w.curselection) unless list_w.curselection.blank?
    end

    scroll_bar = TkScrollbar.new(self) do
      command proc{|*args| list_w.yview(*args)}
      width 10
      relief "flat"
      pack 'side' => 'left', 'fill' => 'y'
    end

    list_w.yscrollcommand {|first,last| scroll_bar.set(first,last) }
  end

end