# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  html = open('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  kickstarter.css("li.project.grid_4").each do |project|
  	title = project.css("h2.bbcard_name strong a").text
  
  	projects[title.to_sym] = {
  		image_link: project.css("div.project-thumbnail a img").attribute("src").value,
  		description: project.css("p.bbcard_blurb").text,
  		location: project.css("ul.project-meta a.data-location.location-name").text,
  		percent_funded: project.css("ul.project-stats li.first.fundedstrong").text.gsub("%","").to_i
  	}
  end
  projects
end