require 'rails_helper'

feature "user comments on articles" do
  let!(:user) { FactoryGirl.create(:user, role: "member") }
  let!(:article) { FactoryGirl.create(:article) }

  scenario "a registered user can comment on an article" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    click_link "#{article.title}"

    expect(page).to have_content("Comments:")

    click_button "Comment"

    expect(page).to_not have_content("can't be blank")
    expect(page).to have_content("Sign Out")
  end

  scenario "an unregistered user can comment on an article" do
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    click_link "#{article.title}"

    expect(page).to have_content("Comments:")

    click_button "Comment"

    expect(page).to_not have_content("can't be blank")
    expect(page).to have_content("Sign Out")
  end

  scenario "a user cannot delete comments" do
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    click_link "#{article.title}"

    expect(page).to have_content("Comments:")

    expect(page).to_not have_content("Delete Comment")
    expect(page).to have_content("Sign Out")
  end
end
