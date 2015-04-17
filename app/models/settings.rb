class Settings < Settingslogic
	source "#{Rails.root}/config/application.yml"
	namespace Rails.env
	def self.machine_path
		File.join(self.machine_site, self.machine_prefix)
	end

	def self.session_path(session_id)
		return machine_path unless session_id
		File.join(self.machine_site, self.machine_prefix, 'sessions', session_id)
	end

	def self.session_at_path(datetime)
		return machine_path unless datetime
		File.join(self.machine_site, self.machine_prefix, "sessions?at=#{datetime}")
	end
end