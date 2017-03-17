require 'rails_helper'

feature "user sees welcome message on the homepage" do

  scenario "user sees welcome message on the homepage" do
    visit root_path
    expect(page).to have_content("Hi there.")
  end
end
