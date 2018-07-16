require_relative "d6s.rb"

$weather = 10
$wind_dir = 2
$wind_str = 1

#$day[m]

class Weather_day

	attr_reader :weather, :wind, :wind_dir, :wind_str, :special, :moon
	attr_writer :special, :moon

	def initialize
		if rand(3) != 0
			$weather = ($weather + oD6 + oD6 - 8).abs % 41
			$weather = 40 - $weather if $weather > 20
			$weather = 1 if $weather == 0
		end
		if rand(2) != 0
			$wind_dir = ($wind_dir + (oD6 + oD6 - 7)/3) % 8
		end
		if rand(3) != 0
			$wind_str = ($wind_str + (oD6 + oD6 - 6)/6).abs % 4
		end
		
		@weather  = $weather
		@wind_dir = $wind_dir
		@wind_str = $wind_str
		@wind     = (@wind_dir + 1) + ((@wind_str - 1) * 8)
		@wind     = 0 if @wind_str == 0

		@special  = ""
		@moon     = ""
	end
end


class Weather_month

	attr_reader :day, :name

	def initialize(month, weather, wind)

		@name = month
		
		$weather  = weather.to_i
		$wind_str = ((wind.to_i) / 8).ceil
		$wind_dir = (wind.to_i) % 8
		
		@day = []
		28.times do |d|
			@day[d] = Weather_day.new
		end

		case @name
		when "Cal Amae"
			@day[0].special = "Walmaer"
			@day[8].special = "Cal Amae"
		when "Elesi"
			@day[1].special = "Elesi"
		when "Anashina"
			@day[3].special = "Anashina"
			@day[14].special = "Ish Nakil"
			@day[17].special = "Fenimaal"
			@day[20].special = "Fionella"
		when "Gwendyll"
			@day[7].special = "Alesia"
			@day[11].special = "Gwendyll"
		when "MacGillan"
			@day[12].special = "MacGillan"
		when "Juba"
			@day[9].special = "Juba"
		when "Taroc"
			@day[10].special = "Taroc"
			@day[14].special = "Ikalio"
		when "ManPeggon"
			@day[3].special = "Man Peggon"
		when "Maleko"
			@day[0].special = "Maleko"
		when "Fal Munir"
			@day[6].special = "Fal Munir"
			@day[20].special = "Shalissa"
		when "Moltan"
			@day[2].special = "Moltan"
		when "Kraagh"
			@day[7].special = "Kraagh"
		when "Mestronorpha"
			@day[5].special = "Mestronorpha"
			@day[27].special = "Ielina"
		end

		if @name != ""
			@day[0].moon = 0
			@day[7].moon = 1
			@day[14].moon = 2
			@day[21].moon = 3
		end

	end
end
