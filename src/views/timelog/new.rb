class TimelogNew < TkLabelFrame
  def initialize(*args)
    super(*args)
    config
    text "Log Time:"
  end
  
  private
  def config
    @issue = Issue.new

    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkLabel.new(raw){text "Date:"}.pack(:side => "left")
    @date = Tk::Iwidgets::Dateentry.new(raw).pack(:side => 'left')
    
    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkLabel.new(raw){text "Hours:"}.pack(:side => "left")
    @time = TkEntry.new(raw).pack("side"=>"left", "fill"=>"x")
    
    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkLabel.new(raw){text "Comment:"}.pack(:side => "left")
    @comment = TkEntry.new(raw).pack("side"=>"left", "fill"=>"x")
    
    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkLabel.new(raw){text "Activity:"}.pack(:side => "left")
    @activity = TkEntry.new(raw).pack("side"=>"left", "fill"=>"x")

  end
end