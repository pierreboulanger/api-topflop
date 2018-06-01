require 'test_helper'

class FlopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flop = flops(:one)
  end

  test "should get index" do
    get flops_url
    assert_response :success
  end

  test "should get new" do
    get new_flop_url
    assert_response :success
  end

  test "should create flop" do
    assert_difference('Flop.count') do
      post flops_url, params: { flop: { comment: @flop.comment, flopplayer: @flop.flopplayer, game_id: @flop.game_id, user_id: @flop.user_id } }
    end

    assert_redirected_to flop_url(Flop.last)
  end

  test "should show flop" do
    get flop_url(@flop)
    assert_response :success
  end

  test "should get edit" do
    get edit_flop_url(@flop)
    assert_response :success
  end

  test "should update flop" do
    patch flop_url(@flop), params: { flop: { comment: @flop.comment, flopplayer: @flop.flopplayer, game_id: @flop.game_id, user_id: @flop.user_id } }
    assert_redirected_to flop_url(@flop)
  end

  test "should destroy flop" do
    assert_difference('Flop.count', -1) do
      delete flop_url(@flop)
    end

    assert_redirected_to flops_url
  end
end
