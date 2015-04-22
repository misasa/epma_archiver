require 'tmpdir'
require 'find'
class Area < ActiveRecord::Base
	has_many :maps
	has_attached_file :zip
	validates_attachment :zip, content_type: { content_type: ["application/zip"]}


	def full_path
		File.join(Settings.sync_path, path)
	end

	def process
		Dir.mktmpdir do |dir|
			Dir.chdir(dir) do
				safe_name = "map-#{self.id}"
				Dir.mkdir(safe_name)
				Dir.chdir(safe_name) do
					FileUtils.cp_r full_path, Settings.machine_name
					Dir.mkdir('rpl')
					Dir.mkdir('tif')
					Dir.mkdir('jpg')

					maps.each do |map|
						map_name = File.basename(map.path, ".map")
						map_path = File.join(full_path, map_name + ".map")

						info_str = nil
						cmd = "jxmap-info #{map_path}"
						IO.popen(cmd, "r"){|io|
							info_str = io.read
						}
						info = YAML.load(info_str)
						out_name = map_name
						if info["element_name"]
							out_name = info["element_name"]
						elsif info["signal"]
							out_name = info["signal"]
						end

						image_path = File.join('rpl', out_name + ".raw")
						cmd = "jxmap-image #{map_path} #{image_path}"
						system(cmd)

						image_path = File.join('tif', out_name + ".tif")
						cmd = "jxmap-image #{map_path} #{image_path}"
						system(cmd)


						image_path = File.join('jpg', out_name + ".jpg")
						info_path = File.join('jpg', out_name + ".txt")
						cmd = "jxmap-image #{map_path} #{image_path}"
						system(cmd)

						if File.exists?(image_path)
							map.image = File.new(image_path)
						end
						if File.exists?(info_path)
							info_text = File.open(info_path).read
							map.update_with_info(info_text)
						end
						map.save
					end
				end
				zip_path = "#{safe_name}.zip"
				cmd = "zip -r #{zip_path} #{safe_name}"
				system(cmd)
				if File.exists?(zip_path)
					self.zip = File.new(zip_path)
					self.save
				end
			end
		end
	end
end
