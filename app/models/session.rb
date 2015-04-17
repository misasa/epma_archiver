require 'active_resource'
class Session < ActiveResource::Base
	self.site = "http://database.misasa.okayama-u.ac.jp/"
	self.prefix = '/machine/machines/6/'
	self.site = Settings.machine_site
	self.prefix = Settings.machine_prefix

	def self.at(datetime)
		self.find(:first, :params => {:at => datetime})
	end
end
