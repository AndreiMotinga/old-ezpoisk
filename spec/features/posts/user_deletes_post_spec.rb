require "rails_helper"

feature "user deletes post", js: true do
  scenario "successfully" do
    user = create_and_login_user
    record = create :post, user: user, text: "Old Text"

    visit edit_post_path(record)

    click_on "Удалить"

    expect(page).to have_content I18n.t(:p_destroyed)
    user.reload
    expect(user.posts.size).to eq 0
  end
end
