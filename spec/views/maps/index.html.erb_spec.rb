require 'rails_helper'

RSpec.describe "maps/index", type: :view do
  before(:each) do
    assign(:maps, [
      Map.create!(
        :path => "Path",
        :area_id => 1
      ),
      Map.create!(
        :path => "Path",
        :area_id => 1
      )
    ])
  end

  it "renders a list of maps" do
    render
    assert_select "tr>td", :text => "Path".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
