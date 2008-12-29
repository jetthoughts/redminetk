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
ProjectIndex.new(root, projects, proc{|n| puts n})
Tk.mainloop