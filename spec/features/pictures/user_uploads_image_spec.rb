require "rails_helper"

feature "user uploads image" do
  scenario "user is logged in" do
    user = create_and_login_user
    record = create :listing, :job, user: user
    file = "#{Rails.root}/spec/support/images/redhead.jpg"

    visit edit_listing_path record
    attach_file "picture_image", file
    click_on "Upload"

    picture = Picture.last
    expect(picture.user_id).to eq user.id
  end
end
