require 'rails_helper'

feature 'user adds a dream', %(
  As a user
  I want to add a new dream
  So that I can cultivate a dream journal
) do

  # Acceptance Criteria
  # [  ] - User can visit the new dream page
  # [  ] - User can add a valid dream
  # [  ] - User is unable to add an invalid dream
  # [  ] - User is redirected to the dream index page after adding a dream

  scenario 'User visits the new dream page' do
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit new_dream_path
    expect(page).to have_content("New Dream")
  end

  scenario 'User adds valid dream' do
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit new_dream_path
    dream = FactoryGirl.create(:dream)

    fill_in "Title", with: "Womp"
    fill_in "Dream", with: dream.text
    fill_in "dream_date", with: "10/01/2015"

    click_button "Add Dream"

    expect(page).to have_content(dream.title)
    expect(page).to have_content(dream.text)
  end
end
