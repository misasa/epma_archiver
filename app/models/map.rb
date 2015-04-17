class Map < ActiveRecord::Base
	belongs_to :area
	has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>", tiny: "40x40>"}
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg"]}

	def self.parse_info(info)
		lines = info.split("\n")
		h = Hash.new

		title_line = lines.find{|line| line =~ /\$CM_TITLE/ }
		if title_line
			title_line = title_line.strip
			/\$CM_TITLE\s(.*)/ =~ title_line
			data = Regexp.last_match
			title = data[1]
			if title
				/\s(.*)_(.*)_(.*)_(.*)$/ =~ title
				data = Regexp.last_match
				h[:area_name] = $~.pre_match
				h[:element_name] = data[1]
				h[:channel] = data[2]
				h[:crystal_name] = data[3]
				h[:x_ray_name] = data[4]
			end
		end

		if /\$CM_STAGE_POS\s(\S*)\s(\S*)\s(\S*) 0 0 0/ =~ info
			data = Regexp.last_match
			h[:center_x] = data[1]
			h[:center_y] = data[2]
			h[:center_z] = data[3]
		end

		if /\$CM_MAG\s(\S*)/ =~ info
			data = Regexp.last_match
			h[:magnification] = data[1]
		end

		if /\$\$SM_SCAN_ROTATION\s(\S*)/ =~ info
			data = Regexp.last_match
			h[:scan_rotation] = data[1]
		end

		if /\$CM_FULL_SIZE\s(\S*)\s(\S*)/ =~ info
			data = Regexp.last_match
			h[:pixels_x] = data[1]
			h[:pixels_y] = data[2]
		end
		return h
	end

	def update_with_info(info_text)
		info = self.class.parse_info(info_text)
		self.element_name = info[:element_name]
		self.channel = info[:channel]
		self.crystal_name = info[:crystal_name]
		self.x_ray_name = info[:x_ray_name]
		self.info = info_text
		self.save
		if area
			area.name = info[:area_name] unless area.name
			area.center_x = info[:center_x].to_f unless area.center_x
			area.center_y = info[:center_y].to_f unless area.center_y
			area.center_z = info[:center_z].to_f unless area.center_z
			area.pixels_x = info[:pixels_x].to_i unless area.pixels_x
			area.pixels_y = info[:pixels_y].to_i unless area.pixels_y
			area.magnification = info[:magnification].to_f unless area.magnification
			area.save
		end
	end



end
