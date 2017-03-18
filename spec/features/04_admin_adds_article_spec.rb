require 'rails_helper'

feature "admin adds an article" do
  let!(:user) { FactoryGirl.create(:user, role: "admin") }
  let!(:article) { FactoryGirl.create(:article, user: user) }

  scenario "admin posts an article" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("Post New Article")

    click_link "Post New Article"
    fill_in "Title", with: article.title
    fill_in "Body", with: article.body
    click_button "Post"

    expect(page).to have_content("Your new article has posted!")
    expect(page).to have_content("Sign Out")
  end

  xit "admin edits an article" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("View Your Articles")

    visit user_articles_path(user)

    click_link article.title

    expect(page).to have_content("by | #{article.user.first_name}")
    expect(page).to have_content("Edit #{article.title}")

    click_link "Edit #{article.title}"

    click_button "Post"

    expect(page).to have_content("Your new article has updated!")
    expect(page).to have_content("Sign Out")
  end
end
