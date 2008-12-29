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

projects = {}
Project.find(:all).each{|p| projects[p.name] = p}

root = TkRoot.new { title "Time Tracker For Redmine" }

project_list = ProjectIndex.new(root, projects.map{|k,v| k})
#issue_list = IssueIndex.new(root)
Tk.mainloop