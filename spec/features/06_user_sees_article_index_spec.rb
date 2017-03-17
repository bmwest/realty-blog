require 'rails_helper'

feature "user sees articles" do
  let!(:user) { FactoryGirl.create(:user, role: "member") }
  let!(:article) { FactoryGirl.create(:article) }

  xit "a registered user can see all articles" do
    sign_in(user)

    expect(page).to have_content("Hey, nice to see you again.")
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"
    expect(page).to have_content("Delete #{article.title}")

    click_button "Delete #{article.title}"

    expect(page).to_not have_content(article.title)
    expect(page).to have_content("Sign Out")
  end

  xit "an unregistered user can see all articles" do
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"

    expect(page).to have_content(article.title)
    expect(page).to have_content("Sign Out")
  end

  xit "a user cannot edit articles" do
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"

    expect(page).to have_content(article.title)
    expect(page).to_not have_content("Edit #{article.title}")
    expect(page).to have_content("Sign Out")
  end

  xit "a user cannot delete articles" do
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"

    expect(page).to have_content(article.title)
    expect(page).to_not have_content("Delete #{article.title}")
    expect(page).to have_content("Sign Out")
  end

  xit "a user cannot delete articles" do
    expect(page).to have_content("View All Articles")

    click_link "View All Articles"

    expect(page).to have_content(article.title)
    expect(page).to_not have_content("Edit #{article.title}")
    expect(page).to have_content("Sign Out")
  end
end
