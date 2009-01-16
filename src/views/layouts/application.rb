class Application

  attr_accessor :projects_frame, :issues_frame, :issue_frame, :spent_time_frame

  def initialize(projects_frame = TkFrame, issues_frame = TkFrame, issue_frame = TkFrame, spent_time_frame = TkFrame)
    @root = TkRoot.new {title "Time Tracker For Redmine"}

    tpaned = TkPanedwindow.new(@root) do
      orient "horizontal"
      pack :fill => "both", :expand => 1
    end

    @projects_frame = projects_frame.new(@root)

    rpaned = TkPanedwindow.new(@root) do
      orient "vertical"
      pack :fill => "both", :expand => 1
    end

    rtpaned = TkPanedwindow.new(@root) do
      orient "horizontal"
      pack :fill => "both", :expand => 1
    end

    @issues_frame = issues_frame.new(@root) do
      height 200
    end

    @issue_frame = issue_frame.new(@root)
    @spent_time_frame = spent_time_frame.new(@root)

    rtpaned.add @issues_frame
    rtpaned.add @issue_frame

    rpaned.add rtpaned
    rpaned.add @spent_time_frame

    tpaned.add @projects_frame
    tpaned.add rpaned
  end

  def run
    Tk.mainloop
  end
end
