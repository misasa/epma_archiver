require 'active_resource'
class Session < ActiveResource::Base
	self.site = "http://database.misasa.okayama-u.ac.jp/"
	self.prefix = '/machine/machines/6/'
	def self.at(datetime)
		self.find(:first, :params => {:at => datetime})
	end
end
