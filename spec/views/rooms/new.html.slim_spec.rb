require 'rails_helper'

RSpec.describe "rooms/new", type: :view do
  before(:each) do
    assign(:room, Room.new(
      :room_code => "MyString",
      :room_name => "MyString",
      :location => "MyString",
      :ip_address => "MyString"
    ))
  end

  it "renders new room form" do
    render

    assert_select "form[action=?][method=?]", rooms_path, "post" do

      assert_select "input#room_room_code[name=?]", "room[room_code]"

      assert_select "input#room_room_name[name=?]", "room[room_name]"

      assert_select "input#room_location[name=?]", "room[location]"

      assert_select "input#room_ip_address[name=?]", "room[ip_address]"
    end
  end
end
