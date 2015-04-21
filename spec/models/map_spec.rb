require 'rails_helper'

RSpec.describe Map, type: :model do
	describe ".parse_info" do
		subject { Map.parse_info(info) }
		#let(:map) { FactoryGirl.create(:map, :path => 'ref/mount-magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0001/data004.map') }
		context "with valid info" do
			let(:info){ <<-EOF
	$CM_TITLE ref-mag-kam5 Fe_CH4_LIFL_Ka
	$CM_MAG 133
	$CM_FULL_SIZE 1800 1600
	$CM_STAGE_POS 16.5407 19.9220 11.0355 0 0 0
	$$SM_SCAN_ROTATION 0.00
	EOF
				}

			it { expect(subject).to include(:element_name => 'Fe') }
			it { expect(subject).to include(:channel => 'CH4') }
			it { expect(subject).to include(:crystal_name => 'LIFL') }
			it { expect(subject).to include(:x_ray_name => 'Ka') }
		end

		context "with invalid info" do
			let(:info){ "" }
			it { expect(subject).to be_eql({}) }
		end
	end

	describe "#update_with_info" do
		subject { map.update_with_info(info) }
		let(:area) { FactoryGirl.create(:area, :name => nil, :path => 'ref/mount-magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0001') }		
		let(:map) { FactoryGirl.create(:map, :path => 'ref/mount-magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0001/data004.map') }
		context "with valid info" do
			let(:info){ <<-EOF
	$CM_TITLE ref-mag-kam5 Fe_CH4_LIFL_Ka
	$CM_MAG 133
	$CM_FULL_SIZE 1800 1600
	$CM_STAGE_POS 16.5407 19.9220 11.0355 0 0 0
	$$SM_SCAN_ROTATION 0.00
	EOF
				}
			before do
				area.maps << map
				subject
			end
			it { expect(map.element_name).to be_eql('Fe') }
			it { expect(map.signal).to be_eql('Fe_CH4_LIFL_Ka') }
			it { expect(area.name).to be_eql('ref-mag-kam5') }

		end

		context "with compo info" do
			let(:info){ <<-EOF
	$CM_TITLE ref-mag-kam5 COMPO
	$CM_MAG 133
	$CM_FULL_SIZE 1800 1600
	$CM_STAGE_POS 16.5407 19.9220 11.0355 0 0 0
	$$SM_SCAN_ROTATION 0.00
	EOF
				}
			before do
				area.maps << map
				subject
			end
			it { expect(map.signal).to be_eql('COMPO') }
			it { expect(area.name).to be_eql('ref-mag-kam5') }

		end


		context "with valid info without area" do
			let(:info){ <<-EOF
	$CM_TITLE ref-mag-kam5 Fe_CH4_LIFL_Ka
	$CM_MAG 133
	$CM_FULL_SIZE 1800 1600
	$CM_STAGE_POS 16.5407 19.9220 11.0355 0 0 0
	$$SM_SCAN_ROTATION 0.00
	EOF
				}
			before do
				#area.maps << map
				map
				area
				subject
			end
			it { expect(map.element_name).to be_eql('Fe') }
			it { expect(area.name).not_to be_eql('ref-mag-kam5') }

		end

		context "with invalid info" do
			let(:info){ "" }
			before do
				area.maps << map
				subject
			end

			it { expect(map.element_name).to be_nil }
		end

	end
end
