require 'tmpdir'
require 'find'
class Area < ActiveRecord::Base
	has_many :maps, dependent: :destroy
	has_attached_file :zip, {:preserve_files => false }
	validates_attachment :zip, content_type: { content_type: ["application/zip"]}

#    paginates_per 5  # 1ページあたり2項目表示

	def full_path
		File.join(Settings.sync_path, path)
	end

	def prepare_maps
		sync_path = Settings.sync_path
		base_path = Pathname.new(Settings.sync_path)

		map_files = Dir.glob(File.join(full_path, "*.map"))
		map_files.each do |map_file|
			path = Pathname.new(map_file)
			relative_path = path.relative_path_from(base_path)
			map_path = relative_path.to_s
			if map = maps.find_by_path(map_path)
				map.mtime = path.mtime
				map.ctime = path.ctime
			else
				maps << Map.create(:path => map_path, :mtime => path.mtime, :ctime => path.ctime)
			end
		end
	end

	def latest_map
		maps.order("mtime desc").first
	end

	def maps_mtime
		return unless latest_map
		latest_map.mtime
	end

	def process
		Dir.mktmpdir do |dir|
			Dir.chdir(dir) do
				safe_name = "map-#{self.id}"
				Dir.mkdir(safe_name)
				Dir.chdir(safe_name) do
					Dir.mkdir(Settings.machine_name)
					Dir.mkdir('rpl')
					Dir.mkdir('tif')
					Dir.mkdir('jpg')
					map_files = Dir.glob(File.join(full_path, "*.map"))
					map_z_files = Dir.glob(File.join(full_path, "*.map.Z"))
					cnd_files = Dir.glob(File.join(full_path, "*.cnd"))
					
					FileUtils.cp(map_files, Settings.machine_name) unless map_files.empty?
					FileUtils.cp(map_z_files, Settings.machine_name) unless map_z_files.empty?
					FileUtils.cp(cnd_files, Settings.machine_name) unless cnd_files.empty?
					maps.each do |map|

						map_name = File.basename(map.path, ".map")
						map_path = File.join(full_path, map_name + ".map")

						info_str = nil
						cmd = "jxmap-info '#{map_path}'"
						IO.popen(cmd, "r"){|io|
							info_str = io.read
						}
						info = YAML.load(info_str)
						out_name = map_name
						if info
							if info["element_name"]
								out_name = info["element_name"]
							elsif info["signal"]
								out_name = info["signal"]
							end
						end

						image_path = File.join('rpl', out_name + ".raw")
						cmd = "jxmap-image '#{map_path}' '#{image_path}'"
						system(cmd)

						image_path = File.join('tif', out_name + ".tif")
						cmd = "jxmap-image '#{map_path}' '#{image_path}'"
						system(cmd)


						image_path = File.join('jpg', out_name + ".jpg")
						info_path = File.join('jpg', out_name + ".txt")
						cmd = "jxmap-image '#{map_path}' '#{image_path}'"
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
