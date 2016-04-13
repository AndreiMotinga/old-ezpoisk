# require "rails_helper"
#
# feature "user creates post" do
#   scenario "successfully", js: true do
#     # create_alabama_and_abbeville
#     user = create_and_login_user
#
#     visit new_dashboard_post_path
#     attrs = build(:post)
#     fill_in "Заголовок", with: attrs.title
#     # summernote shit
#     # select("Alabama", from: "Штат")
#     # select("Abbeville", from: "Город")
#     click_on "Сохранить"
#
#     expect(page).to have_content attrs.title
#   end
# end
