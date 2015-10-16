require 'rails_helper'

feature 'user edits a dream', %(
  As a user
  I want to add a new dream
  So that I can cultivate a dream journal
) do

  # Acceptance Criteria
  # [X] - User can visit edit page for a dream instance
  # [X] - User can change dream content, title, and date
  # [ ] - Content changes update keyword analysis
  # [ ] - Title changes are reflected on the show page
  # [ ] - Time changes are reflected in the timeline
  # [X] - User cannot edit a dream with invalid information

  scenario 'User visits the edit dream page' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    dream = create_dream(user)
    visit edit_dream_path(dream)
    expect(page).to have_content("Edit")
    expect(page).to have_content(dream.title)
  end

  scenario 'with valid information' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    dream = create_dream(user)

    visit edit_dream_path(dream)

    fill_in "Title", with: "Tester tester"
    fill_in "Dream", with: "This is the new dream description"
    fill_in "dream_date", with: "10/15/2015"

    click_button "Update"

    expect(page).to have_content("Tester tester")
    expect(page).to have_content("Dream Journal")
  end

  scenario 'with invalid information' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    dream = create_dream(user)

    visit edit_dream_path(dream)

    fill_in "Dream", with: ""

    click_button "Update"

    expect(page).to have_content("Text can't be blank")
  end

  scenario "keyword analysis changes upon update" do

  end
end
