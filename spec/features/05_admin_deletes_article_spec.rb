require 'rails_helper'

feature "admin deletes an article" do
  let!(:user) { FactoryGirl.create(:user, role: "admin") }
  let!(:article) { FactoryGirl.create(:article, user: user) }

  scenario "admin deletes an article" do
    sign_in(user)

    expect(page).to have_content("Nice to see you again.")
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    expect(page).to have_content("Delete #{article.title}")

    click_link "Delete #{article.title}"

    expect(page).to_not have_content(article.title)
    expect(page).to have_content("The article has been deleted")
    expect(page).to have_content("Sign Out")
  end
end
