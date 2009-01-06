require 'tk'
require "activeresource"
require "models/rest"

require 'views/layouts/application'

#Projects
require "models/project"
require "views/projects/index"

#Issues
require "models/issue"
require "views/issues/index"
require "views/issues/show"

#Account
require "models/timelog"

def show_content(cont)
  cont.nil? ? "--" : cont
end

def show_users(users)
  show_content(users.map{|u| u.lastname}.join(","))
end

def show_issue(issue)
  @app.issue_frame.issue = issue
end

def show_issues_for(project)
  @issues = project.issues
  @app.issues_frame.issues = @issues.map do |i|
    "#{i.id}: " +
    (i.project_id != project.id ? i.project.to_s + " - " : "" ) + 
      "#{i.subject}"
  end
end

@app = Application.new(ProjectIndex, IssueIndex, IssueShow)

@projects = Project.find(:all)
@issues = []

@app.projects_frame.projects=@projects.map{|k,v| k}
@app.projects_frame.onchange = proc{|id| show_issues_for(@projects[id])}

@app.issues_frame.onchange = proc{|id| show_issue(@issues[id])}

@app.run