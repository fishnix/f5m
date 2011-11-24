require 'test_helper'

class BipprofilesControllerTest < ActionController::TestCase
  setup do
    @bipprofile = bipprofiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bipprofiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bipprofile" do
    assert_difference('Bipprofile.count') do
      post :create, :bipprofile => @bipprofile.attributes
    end

    assert_redirected_to bipprofile_path(assigns(:bipprofile))
  end

  test "should show bipprofile" do
    get :show, :id => @bipprofile.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bipprofile.to_param
    assert_response :success
  end

  test "should update bipprofile" do
    put :update, :id => @bipprofile.to_param, :bipprofile => @bipprofile.attributes
    assert_redirected_to bipprofile_path(assigns(:bipprofile))
  end

  test "should destroy bipprofile" do
    assert_difference('Bipprofile.count', -1) do
      delete :destroy, :id => @bipprofile.to_param
    end

    assert_redirected_to bipprofiles_path
  end
end
