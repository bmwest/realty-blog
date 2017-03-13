require 'rails_helper'

feature "user signs up" do
  scenario "required and valid information provided" do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Rosalind'
    fill_in 'Last Name', with: 'Sermanlok'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Hi, it's nice to meet you.")
    expect(page).to have_content("Sign Out")
  end

  scenario "required information is not provided" do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "password confirmation does not match password " do
    visit root_path
    click_link 'Sign Up'

    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'notpasswprd'

    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
