class TimelogNew < TkLabelFrame
  def initialize(*args)
    super(*args)
    text "Log Time:"
    @activity = TkVariable.new
    @activities = TimeEntry.available_enumerations
    config
  end

  def issue=(issue)
    @issue = issue
  end

  private
  def config

    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkLabel.new(raw){text "Date:"}.pack(:side => "left")
    @date = Tk::Iwidgets::Dateentry.new(raw).pack(:side => 'left', :pady => 10)

    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkLabel.new(raw){text "Hours:"}.pack(:side => "left")
    @time = TkEntry.new(raw){width 5}.pack("side"=>"left", "fill"=>"x", :pady => 10)

    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkLabel.new(raw){text "Comment:"}.pack(:side => "left")
    @comment = TkEntry.new(raw){
      width 35
    }.pack("side"=>"left", "fill"=>"x", :pady => 10)

    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkLabel.new(raw){text "Activity:"}.pack(:side => "left")
    TkOptionMenubutton.new(raw, @activity, *TkVariable.new(@activities)).pack('side' => 'left', 'fill' => 'x', :pady => 10)

    p = proc {|*args| commit_time(args)}
    raw = TkFrame.new(self).pack(:side => 'top', :fill => 'x')
    TkButton.new(raw) do
      text("Save")
      command p
      pack :side => "right"
    end
  end

  def commit_time(args)
    return if @issue.nil? or !@time.value or !@date.get
    @activities.each do |a|
      if a.name == @activity.value
        TimeEntry.commit(@issue.id, :comments => @comment.value, :hours => @time.value, :activity_id => a.id, :spent_on => @date.get)
        break
      end
    end
  end


end
