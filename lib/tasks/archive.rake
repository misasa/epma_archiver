require "find"
require "pathname"
namespace :archive do
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
				end

				map = Map.find_by_path(map_path)
				unless map
					map = Map.create(:path => map_path, :mtime => path.mtime, :ctime => path.ctime)
					area.maps << map
				end
			end
		end
	end
end
