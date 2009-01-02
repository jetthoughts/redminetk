require 'tk'
require "activeresource"
require "models/rest"

#Projects
require "models/project"
require "views/projects/index"

#Issues
require "models/issue"
require "views/issues/index"
require "views/issues/show"

#Account
require "models/account"

def authenticate
  ActiveResource::Connection.new("http://localhost:3000/").post("/login?username=miry&password=aries")
  false
rescue ActiveResource::Redirection
  true
end

def showIssuesOf(project)
  @issue_list.issues = project.issues.map(&:subject)
end

#puts authenticate
projects = {}
Project.find(:all).each{|p| projects[p.name] = p}

root = TkRoot.new { title "Time Tracker For Redmine" }

@issue_list = IssueIndex.new(root)
@project_list = ProjectIndex.new(root, projects.map{|k,v| k}, proc{|p| showIssuesOf(projects[p])})

Tk.mainloop
