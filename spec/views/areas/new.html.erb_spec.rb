require 'rails_helper'

RSpec.describe "areas/new", type: :view do
  before(:each) do
    assign(:area, Area.new(
      :name => "MyString",
      :path => "MyString"
    ))
  end

  it "renders new area form" do
    render

    assert_select "form[action=?][method=?]", areas_path, "post" do

      assert_select "input#area_name[name=?]", "area[name]"

      assert_select "input#area_path[name=?]", "area[path]"
    end
  end
end
