class Application

  attr_accessor :projects_frame, :issues_frame, :issue_frame, :spent_time_frame

  def initialize(projects_frame = TkFrame, issues_frame = TkFrame, issue_frame = TkFrame, spent_time_frame = TkFrame)
    @root = TkRoot.new {title "Time Tracker For Redmine"}

    container = TkPanedwindow.new(@root) do
      orient "horizontal"
      pack :side => "left", :fill => "both", :expand => 1
    end
    
    rightSide = TkPanedwindow.new(@root) do
      orient "vertical"
      pack :side => "right", :fill => "both", :expand => 1
    end

    @projects_frame = projects_frame.new(@root)

    @issues_frame = issues_frame.new(@root) do
      height 200
    end

    @issue_frame = issue_frame.new(@root)
    @spent_time_frame = spent_time_frame.new(@root)
        
    
    container.add @issues_frame
    container.add rightSide
    
    rightSide.add @projects_frame
    rightSide.add @issue_frame
    rightSide.add @spent_time_frame
  end

  def run
    Tk.mainloop
  end
end
