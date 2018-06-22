#!/usr/bin/ruby

require 'erb'
require 'yaml'


class String
  def convert_base(from, to)
    self.to_i(from).to_s(to)
  end
end

#load the user-specified yaml
spec = YAML.load_file('facade.yml.banking')
####################################################################
#			     				 	 WELCOME        PAGE                           #
####################################################################

#load the welcome template
template = File.read('templates/welcome.html.erb')
page = ERB.new(template, 0, "%<>")

#load all the variables for the welcome page
welcomeSpec = spec["welcome"]

# write the file
file = File.open('src/main/webapp/WEB-INF/jsp/welcome.jsp', "w")
file.puts page.result
file.close

####################################################################
#			     				 	            CSS                                #
####################################################################

#load the css template
template = File.read('templates/css.html.erb')
page = ERB.new(template, 0, "%<>")

#load all the variables for the css page
cssSpec = spec['css']

#generate rgb values for user-specified color
match = cssSpec["mainShade"].match /(..)(..)(..)/
red = match[1].convert_base(16, 10)
green = match[2].convert_base(16, 10)
blue = match[3].convert_base(16, 10)

# write the file
file = File.open('src/main/webapp/resources/css/main.css', "w")
file.puts page.result
file.close

exit 0
