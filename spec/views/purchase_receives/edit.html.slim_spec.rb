require 'rails_helper'

RSpec.describe "purchase_receives/edit", type: :view do
  before(:each) do
    @purchase_receive = assign(:purchase_receive, PurchaseReceive.create!(
      :purchase_order => nil,
      :receiver_id => 1,
      :checker_id => 1,
      :notes => "MyString",
      :partial => false,
      :status => "MyString"
    ))
  end

  it "renders the edit purchase_receive form" do
    render

    assert_select "form[action=?][method=?]", purchase_receive_path(@purchase_receive), "post" do

      assert_select "input#purchase_receive_purchase_order_id[name=?]", "purchase_receive[purchase_order_id]"

      assert_select "input#purchase_receive_receiver_id[name=?]", "purchase_receive[receiver_id]"

      assert_select "input#purchase_receive_checker_id[name=?]", "purchase_receive[checker_id]"

      assert_select "input#purchase_receive_notes[name=?]", "purchase_receive[notes]"

      assert_select "input#purchase_receive_partial[name=?]", "purchase_receive[partial]"

      assert_select "input#purchase_receive_status[name=?]", "purchase_receive[status]"
    end
  end
end
