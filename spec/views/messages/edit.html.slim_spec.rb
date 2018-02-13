require 'rails_helper'

RSpec.describe "messages/edit", type: :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :subject => "MyString",
      :creator => nil,
      :body => "MyString",
      :parent => nil,
      :is_reminder => false,
      :remind_frequency => nil,
      :tags => "MyString",
      :folder => nil
    ))
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(@message), "post" do

      assert_select "input#message_subject[name=?]", "message[subject]"

      assert_select "input#message_creator_id[name=?]", "message[creator_id]"

      assert_select "input#message_body[name=?]", "message[body]"

      assert_select "input#message_parent_id[name=?]", "message[parent_id]"

      assert_select "input#message_is_reminder[name=?]", "message[is_reminder]"

      assert_select "input#message_remind_frequency_id[name=?]", "message[remind_frequency_id]"

      assert_select "input#message_tags[name=?]", "message[tags]"

      assert_select "input#message_folder_id[name=?]", "message[folder_id]"
    end
  end
end
