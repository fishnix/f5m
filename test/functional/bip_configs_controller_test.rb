require 'test_helper'

class BipConfigsControllerTest < ActionController::TestCase
  setup do
    @bip_config = bip_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bip_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bip_config" do
    assert_difference('BipConfig.count') do
      post :create, :bip_config => @bip_config.attributes
    end

    assert_redirected_to bip_config_path(assigns(:bip_config))
  end

  test "should show bip_config" do
    get :show, :id => @bip_config.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bip_config.to_param
    assert_response :success
  end

  test "should update bip_config" do
    put :update, :id => @bip_config.to_param, :bip_config => @bip_config.attributes
    assert_redirected_to bip_config_path(assigns(:bip_config))
  end

  test "should destroy bip_config" do
    assert_difference('BipConfig.count', -1) do
      delete :destroy, :id => @bip_config.to_param
    end

    assert_redirected_to bip_configs_path
  end
end
