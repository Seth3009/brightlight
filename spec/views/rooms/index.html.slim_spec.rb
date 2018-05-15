require 'rails_helper'

RSpec.describe "rooms/index", type: :view do
  before(:each) do
    assign(:rooms, [
      Room.create!(
        :room_code => "Room Code",
        :room_name => "Room Name",
        :location => "Location",
        :ip_address => "Ip Address"
      ),
      Room.create!(
        :room_code => "Room Code",
        :room_name => "Room Name",
        :location => "Location",
        :ip_address => "Ip Address"
      )
    ])
  end

  it "renders a list of rooms" do
    render
    assert_select "tr>td", :text => "Room Code".to_s, :count => 2
    assert_select "tr>td", :text => "Room Name".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Ip Address".to_s, :count => 2
  end
end
