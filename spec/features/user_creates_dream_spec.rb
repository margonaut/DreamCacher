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

end
