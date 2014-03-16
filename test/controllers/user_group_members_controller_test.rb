require 'test_helper'

class UserGroupMembersControllerTest < ActionController::TestCase
  setup do
    @user_group_member = user_group_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_group_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_group_member" do
    assert_difference('UserGroupMember.count') do
      post :create, user_group_member: { status: @user_group_member.status, user_group_id: @user_group_member.user_group_id, user_id: @user_group_member.user_id }
    end

    assert_redirected_to user_group_member_path(assigns(:user_group_member))
  end

  test "should show user_group_member" do
    get :show, id: @user_group_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_group_member
    assert_response :success
  end

  test "should update user_group_member" do
    patch :update, id: @user_group_member, user_group_member: { status: @user_group_member.status, user_group_id: @user_group_member.user_group_id, user_id: @user_group_member.user_id }
    assert_redirected_to user_group_member_path(assigns(:user_group_member))
  end

  test "should destroy user_group_member" do
    assert_difference('UserGroupMember.count', -1) do
      delete :destroy, id: @user_group_member
    end

    assert_redirected_to user_group_members_path
  end
end
