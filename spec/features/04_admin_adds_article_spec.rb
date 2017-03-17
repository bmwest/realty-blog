require 'rails_helper'

feature "admin adds an article" do
  let!(:user) { FactoryGirl.create(:user, role: "admin") }
  let!(:article) { FactoryGirl.create(:article) }

  xit "admin posts an article" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("Post New Article")

    click_link "Post New Article"
    fill_in "Title", with: article.title
    fill_in "Body", with: article.body
    fill_in "Author", with: article.author
    click_button "Post"

    expect(page).to have_content("Your new article has posted!")
    expect(page).to have_content("Sign Out")
  end

  xit "admin edits an article" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("View All Articles")

    visit article_path(article)
    expect(page).to have_content("Edit #{article.title}")

    click_button "Post"

    expect(page).to have_content("Your new article has updated!")
    expect(page).to have_content("Sign Out")
  end
end
