module AresMUSH
  class RandomColorizer
    
    # Randomly rotates between colors in a list, based on the seconds value of the current time.
    def self.random_color
    #	colors = Global.read_config("skin", "random_colors") || [ '%xc', '%xb', '%xg', '%xr' ]
	  Month = DateTime.new.month 
	  case month
		when 3 .. 5
			colors = [ '%x155', '', '', '' ]
		when 6 .. 8
			colors = [ '%196', '', '', '' ]
		when 9 .. 11
			colors = [ '%x214', '', '', '' ]
		else
			colors = [ '%x51', '', '', '' ]
	  end
      bracket_width = 60 / colors.count
      index = Time.now.sec / bracket_width
      colors[index]
    end
    
  end
end