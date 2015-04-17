require 'rails_helper'
RSpec.describe Session, type: :model do
	describe ".find" do
		let(:sessions){ Session.find(:all) }
		before do
			puts Session.collection_path
		end
		it { expect(Session.find(:all)).not_to be_nil}
	end


	describe ".at with datetime" do
		let(:ok_datetime){ '2015-03-31 18:29:52 UTC' }
		let(:ng_datetime){ '2014-03-31 18:29:52 UTC' }

		it { expect(Session.at(ok_datetime)).to be_an_instance_of(Session) }
		it { expect(Session.at(ng_datetime)).to be_nil }
	end

end
