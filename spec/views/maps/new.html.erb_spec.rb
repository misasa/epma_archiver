require 'rails_helper'

RSpec.describe "maps/new", type: :view do
  before(:each) do
    assign(:map, Map.new(
      :path => "MyString",
      :area_id => 1
    ))
  end

  it "renders new map form" do
    render

    assert_select "form[action=?][method=?]", maps_path, "post" do

      assert_select "input#map_path[name=?]", "map[path]"

      assert_select "input#map_area_id[name=?]", "map[area_id]"
    end
  end
end
