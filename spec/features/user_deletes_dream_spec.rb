require 'rails_helper'

feature 'user deletes a dream', %(
  As a user
  I want to delete a dream record
  So I can change my mind about which dreams are valuable
) do

  # Acceptance Criteria
  # [X] - User sees a delete link on a dream show page
  # [X] - When a user deletes a dream, it disappears from the timeline
  # [ ] - When a dream is deleted, all keyword and analytics data is also deleted


  scenario 'sees a delete link on a dream show page' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    dream = create_dream(user)

    visit dreams_path

    expect(page).to have_content("Delete Dream")
  end

  scenario 'When a user deletes a dream, it disappears' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    dream = create_dream(user)

    visit dreams_path

    click_link "Delete Dream"

    expect(page).to_not have_content(dream.title)
    expect(page).to_not have_content(dream.text)
  end
end
