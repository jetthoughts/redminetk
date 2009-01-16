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
    @app.issue_frame.issue = issue
    @app.spent_time_frame.issue = issue
end

def show_issues_for(project)
    @issues = project.issues
    @app.issues_frame.issues = @issues.map do |i|
        "#{i.tracker.name} \##{i.id}: " +
        (i.project_id != project.id ? i.project.to_s + " - " : "" ) +
            "#{i.subject}"
    end

end

#puts TimeEntry.commit(4, :comments => "Hellow", :hours => 22, :activity_id => 9 ).inspect
#exit

@app = Application.new(ProjectIndex, IssueIndex, IssueShow, TimelogNew)

@projects = Project.find(:all)
@issues = []
@enumerations = TimeEntry.available_enumerations

@app.projects_frame.projects = @projects.map{|k,v| k}
@app.projects_frame.onchange = proc{|id| show_issues_for(@projects[id])}

@app.issues_frame.onchange = proc{|id| show_issue(@issues[id])}

@app.run
