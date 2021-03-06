require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, line_item: { description: @line_item.description, ext1: @line_item.ext1, ext2: @line_item.ext2, ext3: @line_item.ext3, invoice_id: @line_item.invoice_id, price: @line_item.price, quantity: @line_item.quantity }
    end

    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { description: @line_item.description, ext1: @line_item.ext1, ext2: @line_item.ext2, ext3: @line_item.ext3, invoice_id: @line_item.invoice_id, price: @line_item.price, quantity: @line_item.quantity }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to line_items_path
  end
end
