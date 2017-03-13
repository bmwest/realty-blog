require "rails_helper"

feature 'user sees welcome message on the homepage' do
  let!(:article) { FactoryGirl.create(:article) }

  scenario "user sees welcome message on the homepage" do
    visit root_path
    expect(page).to have_content("Hi there.")
  end
end
