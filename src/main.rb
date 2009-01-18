require 'rubygems'
require 'tk'
#require 'tkextlib/bwidget'
require 'tkextlib/iwidgets'

require "activeresource"

MODELS_PATH = "models"
VIEWS_PATH = "views"

require "models/rest"
libfilespat = File.join("**", "{#{VIEWS_PATH},#{MODELS_PATH}}", "**", "*.rb")
Dir.glob(libfilespat).each{|lib| require lib}

def show_content(cont)
    cont.nil? ? "--" : cont
end

def show_users(users)
    show_content(users.map{|u| u.lastname}.join(","))
end

def show_issue(issue)
    @issue = issue
    @app.issue_frame.issue = @issue
    @app.spent_time_frame.enable
end

def show_issues_for(project)
    @issues = project.issues
    @app.issues_frame.issues = @issues.map do |i|
        "#{i.tracker.name} \##{i.id}: " +
        (i.project_id != project.id ? i.project.to_s + " - " : "" ) +
            "#{i.subject}"
    end

end

def commit_time(time_entry)
  TimeEntry.commit(@issue.id, time_entry) if @issue
end

@projects = Project.find(:all)
@issues = []
@enumerations = TimeEntry.available_enumerations

@app = Application.new(ProjectIndex, IssueIndex, IssueShow, TimeEntriesNew)
@app.projects_frame.projects = @projects.map{|k,v| k}
@app.projects_frame.onchange = proc{|id| show_issues_for(@projects[id])}
@app.issues_frame.onchange = proc{|id| show_issue(@issues[id])}
@app.spent_time_frame.onsubmit = proc{|time_entry| commit_time time_entry}
@app.run
