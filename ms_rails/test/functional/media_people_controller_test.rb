require 'test_helper'

class MediaPeopleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:media_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create media_person" do
    assert_difference('MediaPerson.count') do
      post :create, :media_person => { }
    end

    assert_redirected_to media_person_path(assigns(:media_person))
  end

  test "should show media_person" do
    get :show, :id => media_people(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => media_people(:one).to_param
    assert_response :success
  end

  test "should update media_person" do
    put :update, :id => media_people(:one).to_param, :media_person => { }
    assert_redirected_to media_person_path(assigns(:media_person))
  end

  test "should destroy media_person" do
    assert_difference('MediaPerson.count', -1) do
      delete :destroy, :id => media_people(:one).to_param
    end

    assert_redirected_to media_people_path
  end
end
