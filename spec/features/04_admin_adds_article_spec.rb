require 'rails_helper'

feature "admin adds an article" do
  let!(:user) { FactoryGirl.create(:user, role: "admin") }
  let!(:article) { FactoryGirl.create(:article) }

  scenario "admin posts an article" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("Post New Artcle")

    click_link "Post New Artcle"
    fill_in "Title", with: article.title
    fill_in "Body", with: article.body
    fill_in "Author", with: article.author
    click_button "Post"

    expect(page).to have_content("Your new article has posted!")
    expect(page).to have_content("Sign Out")
  end

  scenario "admin edits an article" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("View All Articles")

    click_link "#{article.title}"
    expect(page).to have_content("Edit #{article.title}")

    click_button "Post"

    expect(page).to have_content("Your new article has updated!")
    expect(page).to have_content("Sign Out")
  end
end
