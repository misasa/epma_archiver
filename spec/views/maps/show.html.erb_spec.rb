require 'rails_helper'

RSpec.describe "maps/show", type: :view do
  before(:each) do
    area = Area.create(:name => "hello")
    @map = assign(:map, Map.create!(
      :path => "Path",
      :area_id => area.id,
      :mtime => Time.now,
      :ctime => Time.now      
    ))
    render
  end

  it "renders attributes in <p>" do
    #render
    expect(rendered).to match(/Path/)
    expect(rendered).to match(/1/)
  end
end
