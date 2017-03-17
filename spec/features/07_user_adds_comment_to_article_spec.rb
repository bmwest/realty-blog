require 'rails_helper'

feature "user comments on articles" do
  let!(:user) { FactoryGirl.create(:user, role: "member") }
  let!(:article) { FactoryGirl.create(:article) }

  xit "a registered user can comment on an article" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    expect(page).to have_content("Comments:")

    click_button "Comment"

    expect(page).to_not have_content("can't be blank")
    expect(page).to have_content("Sign Out")
  end

  xit "an unregistered user can comment on an article" do
    visit root_path
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    expect(page).to have_content("Comments:")

    click_button "Comment"

    expect(page).to_not have_content("can't be blank")
    expect(page).to have_content("Sign Out")
  end

  xit "a user cannot delete comments" do
    visit root_path
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    expect(page).to have_content("Comments:")

    expect(page).to_not have_content("Delete Comment")
    expect(page).to have_content("Sign Out")
  end
end
