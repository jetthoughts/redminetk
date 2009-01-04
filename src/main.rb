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
require "models/account"


def showIssuesOf(project)
  @issue_list.issues = project.issues.map do |i|
    "#{i.project.to_s+" - " if i.project_id != project.id}" + " #{i.subject}"
  end
end

#puts authenticate


app = Application.new(ProjectIndex, IssueIndex)

projects = {}
Project.find(:all).each{|p| projects[p.name] = p}
puts app.projects_frame.projects=projects.map{|k,v| k}

#@issue_list = IssueIndex.new(root)
#@project_list = ProjectIndex.new(root, projects.map{|k,v| k}, proc{|p| showIssuesOf(projects[p])})
app.run