require 'rails_helper'

feature "admin removes a comment" do
  let!(:user_A) { FactoryGirl.create(:user, role: "admin") }
  let!(:user_M) { FactoryGirl.create(:user, role: "member") }
  let!(:article) { FactoryGirl.create(:article, user: user_A) }
  let!(:comment1) { FactoryGirl.create(:comment, article: article, commenter: "Guest") }
  let!(:comment2) { FactoryGirl.create(:comment, article: article, user: user_M) }

  scenario "admin removes a comment" do
    sign_in(user_A)

    expect(page).to have_content("Nice to see you again.")
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"

    visit article_path(article)

    expect(page).to have_content("Delete #{comment1.commenter}'s Comment")
    expect(page).to have_content("Delete #{comment2.user.first_name}'s Comment")

    click_link "Delete #{comment1.commenter}'s Comment"

    expect(page).to_not have_content(comment1.body)
    expect(page).to have_content("Comment was successfully Deleted.")
    expect(page).to have_content("Sign Out")
  end
end
