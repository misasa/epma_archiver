require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AreasHelper. For example:
#
# describe AreasHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
# RSpec.describe AreasHelper, type: :helper do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe AreasHelper, type: :helper do
	describe AreasHelper do

	  describe "top_message" do
	  	let(:area) {Area.create!(params)}
	  	let(:params){
	  		{
	      		:path => "ref/mount-magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0003"
	      	}
	    }
	    let(:zip){ double("zip", zip_params)}
	    let(:zip_params){{:path => nil}}
	    before(:each) do
	    	allow(area).to receive(:zip).and_return(zip)
	    	assign(:area, area)
	    end

	    context "without zip path" do
		    it "shows message" do
		      expect(helper.top_message).to eq("Processing ...")
		    end
	    end
	    context "with zip path" do
		    let(:zip_params){{:path => "zip/path/exaample.zip", :url => "zip/url/example.zip"}}
		    context "with area name" do
			  	let(:params){
			  		{
			  			:name => name,
			      		:path => "ref/mount-magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0003"
			      	}
			    }
			    let(:name){ "ref-mag-ken3" } 
			    it "shows message" do
			      expect(helper.top_message).to match(/^This page summarizes a map analysis on an area/)
			    end	    	
		    end

	    end
	  end
	end
end
