require 'rails_helper'

RSpec.describe Area, type: :model do
	describe "#.process" do
		let(:area) { FactoryGirl.create(:area, :name => nil, :path => 'ref/mount magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0001') }
		let(:map) { FactoryGirl.create(:map, :path => 'ref/mount magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0001/data004.map') }
		before do
			area
			area.maps << map
		end
		it {expect(area.process).not_to be_nil }
		# after do
		# 	p area
		# 	p map
		# 	p map.image.url(:tiny)
		# 	p map.image.path(:tiny)
		# 	p area.zip.url
		# end
	end
end
