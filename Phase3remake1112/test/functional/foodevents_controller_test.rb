require 'test_helper'

class FoodeventsControllerTest < ActionController::TestCase
  setup do
    @foodevent = foodevents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foodevents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create foodevent" do
    assert_difference('Foodevent.count') do
      post :create, foodevent: @foodevent.attributes
    end

    assert_redirected_to foodevent_path(assigns(:foodevent))
  end

  test "should show foodevent" do
    get :show, id: @foodevent.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @foodevent.to_param
    assert_response :success
  end

  test "should update foodevent" do
    put :update, id: @foodevent.to_param, foodevent: @foodevent.attributes
    assert_redirected_to foodevent_path(assigns(:foodevent))
  end

  test "should destroy foodevent" do
    assert_difference('Foodevent.count', -1) do
      delete :destroy, id: @foodevent.to_param
    end

    assert_redirected_to foodevents_path
  end
end
