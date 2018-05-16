require 'rails_helper'

RSpec.describe "rooms/show", type: :view do
  before(:each) do
    @room = assign(:room, Room.create!(
      :room_code => "Room Code",
      :room_name => "Room Name",
      :location => "Location",
      :ip_address => "Ip Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Room Code/)
    expect(rendered).to match(/Room Name/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Ip Address/)
  end
end
