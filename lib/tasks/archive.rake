require "find"
require "pathname"
require 'logger'
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
		log = Logger.new(STDOUT)
		log.level = Logger::INFO
		log.info("archive:parse started")
		#p "archive:parse starting..."
		sync_path = Settings.sync_path
		base_path = Pathname.new(Settings.sync_path)
		Find.find(sync_path) do |file_path|
			path = Pathname.new(file_path)
			log.debug("#{path} parseing...")
			if path.file? && path.extname == ".map"
				relative_path = path.relative_path_from(base_path)
				map_path = relative_path.to_s
				area_path = relative_path.dirname.to_s
				area = Area.find_by_path(area_path)
				unless area
					log.info("#{area_path} not found")
					area = Area.create(:path => area_path)
				end

				map = Map.find_by_path(map_path)
				unless map
					log.info("#{map_path} not found")					
					map = Map.create(:path => map_path, :mtime => path.mtime, :ctime => path.ctime)
					area.maps << map
				end
				area.mtime = map.mtime
				area.save
			end
		end

		Area.all.each do |area|
			if area.zip_file_size && area.zip_file_size > 0
				#p "already processed!"
			else
				begin
					log.info("#{area.path} processing...")					
					area.process
				rescue => ex
					puts ex
				end
			end
		end		
		log.info("archive:parse finished")
	end

end
