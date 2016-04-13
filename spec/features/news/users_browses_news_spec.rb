require "rails_helper"

feature "User reads news" do
  scenario "successfully" do
    create :post, title: "first"
    create :post, title: "second"

    visit posts_path

    expect(page).to have_content "first"
    expect(page).to have_content "second"
  end
end

feature "User reads post" do
  scenario "success" do
    post = create :post
    visit post_path post

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.text)
  end
end
