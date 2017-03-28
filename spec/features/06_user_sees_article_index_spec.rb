require 'rails_helper'

feature "user sees articles" do
  let!(:user) { FactoryGirl.create(:user, role: "member") }
  let!(:article) { FactoryGirl.create(:article, user: user) }

  scenario "a registered user can see a list of all articles" do
    visit root_path
    sign_in(user)

    expect(page).to have_content("Nice to see you again.")
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"

    expect(page).to have_content(article.title)
    expect(page).to have_content("Sign Out")
  end

  scenario "a registered user can see an individual article" do
    visit root_path
    sign_in(user)

    expect(page).to have_content("Nice to see you again.")
    expect(page).to have_content("View All Articles")
    expect(page).to have_content("Sign Out")

    click_link "View All Articles"
    expect(page).to have_content(article.title)

    visit article_path(article)
    expect(page).to have_content(article.body)
  end

  scenario "an unregistered user can see all articles" do
    visit root_path

    expect(page).to have_content("View All Articles")
    expect(page).to_not have_content("Sign Out")
    expect(page).to_not have_content("Nice to see you again.")

    click_link "View All Articles"

    expect(page).to have_content(article.title)
  end

  scenario "a unregistered user can see an individual article" do
    visit root_path

    expect(page).to have_content("View All Articles")
    expect(page).to_not have_content("Sign Out")
    expect(page).to_not have_content("Nice to see you again.")

    click_link "View All Articles"
    expect(page).to have_content(article.title)

    visit article_path(article)
    expect(page).to have_content(article.body)
  end

  scenario "a user cannot post articles" do
    visit root_path
    sign_in(user)

    expect(page).to have_content("View All Articles")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Nice to see you again.")
    expect(page).to_not have_content("Post New Article")
  end

  scenario "a user cannot edit articles" do
    visit root_path
    sign_in(user)

    expect(page).to have_content("View All Articles")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Nice to see you again.")

    click_link "View All Articles"

    expect(page).to have_content(article.title)
    expect(page).to_not have_content("Edit #{article.title}")
  end

  scenario "a user cannot delete articles" do
    visit root_path
    sign_in(user)

    expect(page).to have_content("View All Articles")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Nice to see you again.")

    click_link "View All Articles"

    expect(page).to have_content(article.title)
    expect(page).to_not have_content("Delete #{article.title}")
  end
end
