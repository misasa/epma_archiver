class Settings < Settingslogic
	source "#{Rails.root}/config/application.yml"
	namespace Rails.env
	def self.machine_path
		File.join(self.machine_site, self.machine_prefix)
	end
end