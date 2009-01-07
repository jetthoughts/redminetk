require 'rubygems'
require 'tk'
#require 'tkextlib/bwidget'
require 'tkextlib/iwidgets'

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

require "models/timelog"
require "views/timelog/new"

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


#t = TimeEntry.find(23)
#t.hours = 10
#t.save
#puts t.inspect
#t.save
#puts TimeEntry.commit(1, :comments => "Hellow", :issue_id => 1, :hours => 22, :activity_id => 9 ).inspect
#exit
@app = Application.new(ProjectIndex, IssueIndex, IssueShow, TimelogNew)

@projects = Project.find(:all)
@issues = []

@app.projects_frame.projects = @projects.map{|k,v| k}
@app.projects_frame.onchange = proc{|id| show_issues_for(@projects[id])}

@app.issues_frame.onchange = proc{|id| show_issue(@issues[id])}

@app.run