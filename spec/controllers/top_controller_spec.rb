require 'rails_helper'

RSpec.describe TopController, type: :controller do

  let(:valid_session) { {} }
  let(:area) { FactoryGirl.create(:area)}
  let(:map) { FactoryGirl.create(:map, :path => 'ref/mount-magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0001/data004.map' ) }
  describe "GET #index" do
  	let(:params) { {} }

    it "returns areas" do
      get :index, params, valid_session
      expect(assigns(:areas)).to eq([area])
    end
  	
  	context "with from to and existing area" do
	  	before do
	  		area
	  		area.maps << map
	  		params[:from] = (map.mtime - 10).strftime("%Y-%m-%d %H:%M:%S")
	  		params[:to] = (map.mtime + 10).strftime("%Y-%m-%d %H:%M:%S")
	  	end
	    it "returns areas" do
	      get :index, params, valid_session
	      expect(assigns(:areas)).to eq([area])
	    end
	end

  	context "with from to and non-existing area" do
	  	before do
	  		area
	  		area.maps << map
	  		params[:from] = (map.mtime - 10).strftime("%Y-%m-%d %H:%M:%S")
	  		params[:to] = (map.mtime - 1).strftime("%Y-%m-%d %H:%M:%S")
	  	end
	    it "returns areas" do
	      get :index, params, valid_session
	      expect(assigns(:areas)).to eq([])
	    end
	end

  end

end
