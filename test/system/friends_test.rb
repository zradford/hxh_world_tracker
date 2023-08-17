require "application_system_test_case"

class FriendsTest < ApplicationSystemTestCase
  setup do
    @friend = friends(:one)
  end

  test "visiting the index" do
    visit friends_url
    assert_selector "h1", text: "Friends"
  end

  test "should create friend" do
    visit friends_url
    click_on "New friend"

    fill_in "Appearance", with: @friend.appearance
    fill_in "Equipment", with: @friend.equipment
    fill_in "Location", with: @friend.location
    fill_in "Name", with: @friend.name
    fill_in "Nen notes", with: @friend.nen_notes
    fill_in "Notes", with: @friend.notes
    fill_in "Occupied with", with: @friend.occupied_with
    click_on "Create Friend"

    assert_text "Friend was successfully created"
    click_on "Back"
  end

  test "should update Friend" do
    visit friend_url(@friend)
    click_on "Edit this friend", match: :first

    fill_in "Appearance", with: @friend.appearance
    fill_in "Equipment", with: @friend.equipment
    fill_in "Location", with: @friend.location
    fill_in "Name", with: @friend.name
    fill_in "Nen notes", with: @friend.nen_notes
    fill_in "Notes", with: @friend.notes
    fill_in "Occupied with", with: @friend.occupied_with
    click_on "Update Friend"

    assert_text "Friend was successfully updated"
    click_on "Back"
  end

  test "should destroy Friend" do
    visit friend_url(@friend)
    click_on "Destroy this friend", match: :first

    assert_text "Friend was successfully destroyed"
  end
end
