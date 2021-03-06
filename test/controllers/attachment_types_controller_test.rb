require 'test_helper'

class AttachmentTypesControllerTest < ActionController::TestCase
  setup do
    @attachment_type = attachment_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attachment_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attachment_type" do
    assert_difference('AttachmentType.count') do
      post :create, attachment_type: { code: @attachment_type.code, name: @attachment_type.name }
    end

    assert_redirected_to attachment_type_path(assigns(:attachment_type))
  end

  test "should show attachment_type" do
    get :show, id: @attachment_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attachment_type
    assert_response :success
  end

  test "should update attachment_type" do
    patch :update, id: @attachment_type, attachment_type: { code: @attachment_type.code, name: @attachment_type.name }
    assert_redirected_to attachment_type_path(assigns(:attachment_type))
  end

  test "should destroy attachment_type" do
    assert_difference('AttachmentType.count', -1) do
      delete :destroy, id: @attachment_type
    end

    assert_redirected_to attachment_types_path
  end
end
