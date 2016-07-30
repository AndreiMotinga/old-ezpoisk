require "rails_helper"

feature "user thanks profile" do
  scenario "user updates contacts", js: true do
    user = create_and_login_user
    me = create :user

    visit profile_path(me)
    find('a[data-id="thanks"]').click
    wait_for_ajax

    expect(page).to have_content "спасибо 1"
    me.reload
    expect(me.points.count).to eq 1
  end
end
