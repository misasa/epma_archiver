require 'rails_helper'

RSpec.describe "maps/edit", type: :view do
  let(:current) { Time.now }  
  before(:each) do
    @map = assign(:map, Map.create!(
      :path => "MyString",
      :area_id => 1,
      :mtime => current,
      :ctime => current
    ))
  end

  it "renders the edit map form" do
    render

    assert_select "form[action=?][method=?]", map_path(@map), "post" do

      assert_select "input#map_path[name=?]", "map[path]"

      assert_select "input#map_area_id[name=?]", "map[area_id]"
    end
  end
end
