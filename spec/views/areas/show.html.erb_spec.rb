require 'rails_helper'

RSpec.describe "areas/show", type: :view do
  before(:each) do
    @area = assign(:area, Area.create!(
      :name => nil,
      :path => "ref/mount-magnetites/2015-03-31/2015-03-31_0001_MAP/Pos_0003"
    ))
    render
    puts rendered
  end

  it "renders attributes in <p>" do
    #render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Path/)
  end
end
