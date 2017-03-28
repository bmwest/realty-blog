require 'rails_helper'

feature "user comments on articles" do
  let!(:user) { FactoryGirl.create(:user, role: "member") }
  let!(:article) { FactoryGirl.create(:article, user: user) }

  scenario "a registered user can comment on an article" do
    sign_in(user)

    expect(page).to have_content("Nice to see you again.")
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    fill_in "Comment:", with: "Loved it"

    click_button "Post"

    expect(page).to have_content("Comments:")
    expect(page).to_not have_content("can't be blank")
    expect(page).to have_content("Sign Out")
  end

  scenario "an unregistered user can comment on an article" do
    visit root_path
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    add_comment

    click_button "Post"

    expect(page).to have_content("Comments:")

    expect(page).to have_content("Comment posted successfully!")
    expect(page).to_not have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "an unregistered user cannot delete comments" do
    visit root_path
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    add_comment

    click_button "Post"

    expect(page).to have_content("Comments:")

    expect(page).to_not have_content("Delete Comment")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "a user can delete comments" do
    sign_in(user)
    visit root_path
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    fill_in "Comment:", with: "Loved it"

    click_button "Post"

    expect(page).to have_content("Comments:")

    expect(page).to have_content("Delete Comment")
    expect(page).to have_content("Sign Out")
  end

  scenario "a user can edit comments" do
    sign_in(user)
    visit root_path
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    visit article_path(article)

    fill_in "Comment:", with: "Loved it"

    click_button "Post"

    expect(page).to have_content("Comments:")

    expect(page).to have_content("Edit Comment")
    expect(page).to have_content("Sign Out")
  end
end
