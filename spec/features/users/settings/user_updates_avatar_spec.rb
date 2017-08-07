require "rails_helper"

feature "user updates avatar" do
  scenario "successfully" do
    user = create_and_login_user

    visit edit_user_path(user, act: "avatar")
    page.attach_file("user_avatar",
                     Rails.root.join("spec/support/images/redhead.jpg" ))
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:user_updated)
    user.reload
    expect(user.avatar).to be_a(Paperclip::Attachment)
  end
end
