#!/usr/bin/env ruby

require "cgi"
require "erb"

load "../includes/includes.rb"

cgi = CGI.new
tmpl = File.read("../town_output.html")

@town_size = cgi["town_size"].to_i
@town_size = 1 if @town_size < 1
@town_size = 100 if @town_size > 100
@town_var  = cgi["town_var"].to_i
aTOWN = Town.new(@town_size, @town_var)
@t = aTOWN.town

# Start: From the CLI module
f = "#################################<By NPCg 0.5>#################################\n\n"

@t.length.times do |house|
	f += "##{house + 1}: #{@t[house][0]}\n"
	@t[house][1..-1].each do |r|
		f += "   #{r}\n"
	end
	f += "\n"
end
	
f += "###############################################################################\n\n"

tfile = "town.txt"
begin
	File.delete(tfile) if File.exists?(tfile)
	File.write(tfile, f, perm: 0644)
rescue
end
# End: From the CLI module

# Generate a relationship map
town_relations("town.txt")
town_dot2txt

out = ERB.new(tmpl)

print "Content-type: text/html\n\n"
print out.result()
