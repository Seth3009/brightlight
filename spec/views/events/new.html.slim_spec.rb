require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :name => "MyString",
      :department => nil,
      :description => "MyString",
      :manager => nil
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_department_id[name=?]", "event[department_id]"

      assert_select "input#event_description[name=?]", "event[description]"

      assert_select "input#event_manager_id[name=?]", "event[manager_id]"
    end
  end
end
