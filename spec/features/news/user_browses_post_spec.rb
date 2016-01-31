require "rails_helper"

feature "User reads post" do
  scenario "success" do
    post = create :post
    visit news_path post

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.text)
  end
end
