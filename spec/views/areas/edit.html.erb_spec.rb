require 'rails_helper'

RSpec.describe "areas/edit", type: :view do
  before(:each) do
    @area = assign(:area, Area.create!(
      :name => "MyString",
      :path => "MyString"
    ))
  end

  it "renders the edit area form" do
    render

    assert_select "form[action=?][method=?]", area_path(@area), "post" do

      assert_select "input#area_name[name=?]", "area[name]"

      assert_select "input#area_path[name=?]", "area[path]"
    end
  end
end
