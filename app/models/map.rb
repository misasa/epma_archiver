class Map < ActiveRecord::Base
	belongs_to :area
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>"}
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg"]}
end
