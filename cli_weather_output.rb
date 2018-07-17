def weather_output(aWEATHER)

	w = aWEATHER

	f = "#################################<By NPCg 0.5>#################################\n\n"

	f += "Month: #{$Month[w.month_n]}\n"
	
	f += "-------------------------------------------------------------------------------\n"
	w.day.each_with_index do |d,i|
		g  = "#{(i+1).to_s.rjust(2)}: #{$Weather[d.weather]}. #{$Wind_str[d.wind_str]}"
		g += " (#{$Wind_dir[d.wind_dir]})" unless d.wind_str == 0
		l1 = g.length
		g += "[#{d.special}]".rjust(60-l1) unless d.special == ""
		l2 = g.length
		f += g
		if w.month_n != 0
			f += "[New moon]".rjust(79-l2) if i == 0
			f += "[½ moon, vaxing]".rjust(79-l2) if i == 7
			f += "[Full moon]".rjust(79-l2) if i == 14
			f += "[½ moon, waning]".rjust(79-l2) if i == 21
		end
		f += "\n"
		f += "-------------------------------------------------------------------------------\n" if ((i+1)%7) == 0 
	end

	f += "\n###############################################################################\n\n"

	wfile = "npcs/weather.npc"
	begin
		File.delete(wfile) if File.exists?(wfile)
		File.write(wfile, f, perm: 0644)
	rescue
		puts "Error writing file #{wfile}"
		gets
	end
	system("#{$editor} #{wfile}")
end
