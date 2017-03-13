require 'rails_helper'

feature 'user signs in' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario "an existing user specifies a valid email and password" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("Sign Out")
  end

  scenario "non-existent log-in information is supplied" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: "noncorrect@email.com"
    fill_in "Password", with: "notcorrectPassword"
    click_button "Sign In"

    expect(page).to have_content("Invalid Email or password.")
    expect(page).to_not have_content("Hey, nice to see you again.")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "an existing user supplies the wrong password" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "notcorrectPassword"
    click_button "Sign In"

    expect(page).to have_content("Invalid Email or password.")
    expect(page).to_not have_content("Hey, nice to see you again.")
  end

  scenario "an already authenticated user cannot re-sign in" do
    sign_in(user)
    visit new_user_session_path

    expect(page).to have_content("Sign Out")
    expect(page).to have_content("You are already signed in")

    visit new_user_session_path

    expect(page).to_not have_content("Sign In")
  end
end
