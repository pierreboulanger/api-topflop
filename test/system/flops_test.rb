require "application_system_test_case"

class FlopsTest < ApplicationSystemTestCase
  setup do
    @flop = flops(:one)
  end

  test "visiting the index" do
    visit flops_url
    assert_selector "h1", text: "Flops"
  end

  test "creating a Flop" do
    visit flops_url
    click_on "New Flop"

    fill_in "Comment", with: @flop.comment
    fill_in "Flopplayer", with: @flop.flopplayer
    fill_in "Game", with: @flop.game_id
    fill_in "User", with: @flop.user_id
    click_on "Create Flop"

    assert_text "Flop was successfully created"
    click_on "Back"
  end

  test "updating a Flop" do
    visit flops_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @flop.comment
    fill_in "Flopplayer", with: @flop.flopplayer
    fill_in "Game", with: @flop.game_id
    fill_in "User", with: @flop.user_id
    click_on "Update Flop"

    assert_text "Flop was successfully updated"
    click_on "Back"
  end

  test "destroying a Flop" do
    visit flops_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Flop was successfully destroyed"
  end
end
