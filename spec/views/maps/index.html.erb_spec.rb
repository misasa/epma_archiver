require 'rails_helper'

RSpec.describe "maps/index", type: :view do
  let(:current) { Time.now }
  before(:each) do
    assign(:q, Map.search({}))

    assign(:maps, [
      Map.create!(
        :path => "Path",
        :area_id => 1,
        :mtime => current,
        :ctime => current
      ),
      Map.create!(
        :path => "Path",
        :area_id => 1,
        :mtime => current,
        :ctime => current
      )
    ])
  end

  it "renders a list of maps" do
    render
#    puts rendered
    assert_select "tr>td", :text => "Path".to_s, :count => 2
    #assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
