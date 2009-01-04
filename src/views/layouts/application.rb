class Application
  
  attr_accessor :projects_frame, :issues_frame, :issue_frame
  
  def initialize(projects_frame = TkFrame, issues_frame = TkFrame, issue_frame = TkFrame)
    @root = TkRoot.new {title "Time Tracker For Redmine"}
    
    tpaned = TkPanedwindow.new(@root) do
      orient "horizontal"
      pack :fill => "both", :expand => 1
    end
    
    @projects_frame = projects_frame.new(@root) do
      width 200
    end
    
    rpaned = TkPanedwindow.new(@root) do
      orient "vertical"
      pack :fill => "both", :expand => 1
    end
    
    @issues_frame = issues_frame.new(@root) do
      height 200
    end
    
    @issue_frame = issue_frame.new(@root)

    rpaned.add @issues_frame
    rpaned.add @issue_frame
    
    tpaned.add @projects_frame
    tpaned.add rpaned
  end
  
  def run
    Tk.mainloop
  end
end
