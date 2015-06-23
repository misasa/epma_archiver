require "find"
require "pathname"
namespace :archive do
	desc "Process map analysis with AREA_ID"
	task :process_area => :environment do
		area_id = ENV["AREA_ID"]
		area_ids = area_id.split(',')
		area_ids.each do |area_id|
			area = Area.find(area_id)
			area.process if area
		end
	end

	desc "Process all map analyses"
	task :process_all_areas => :environment do
		Area.all.each do |area|
			begin
				puts "Area #{area.id} processing..."
				area.process
			rescue => ex
				puts ex
			end
		end
	end


	desc "Parse sync_path"
	task :parse => :environment do
		sync_path = Settings.sync_path
		base_path = Pathname.new(Settings.sync_path)
		Find.find(sync_path) do |file_path|
			path = Pathname.new(file_path)
			if path.file? && path.extname == ".map"
				relative_path = path.relative_path_from(base_path)
				map_path = relative_path.to_s
				area_path = relative_path.dirname.to_s
				area = Area.find_by_path(area_path)
				unless area
					area = Area.create(:path => area_path)
					p area
				end

				map = Map.find_by_path(map_path)
				unless map
					map = Map.create(:path => map_path, :mtime => path.mtime, :ctime => path.ctime)
					p map
					area.maps << map
				end
				area.mtime = map.mtime
				area.save
			end
		end

		Area.all.each do |area|
			p area.name
			p area.zip_file_size
		end		
	end

end
