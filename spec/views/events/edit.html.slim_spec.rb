require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :name => "MyString",
      :department => nil,
      :description => "MyString",
      :manager => nil
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_department_id[name=?]", "event[department_id]"

      assert_select "input#event_description[name=?]", "event[description]"

      assert_select "input#event_manager_id[name=?]", "event[manager_id]"
    end
  end
end
