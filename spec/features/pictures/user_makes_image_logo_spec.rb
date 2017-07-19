require "rails_helper"

feature "user removes image" do
  scenario "user is logged in", js: true do
    user = create_and_login_user
    record = create :listing, :job, user: user
    Picture.create(imageable_id: record.id,
                   imageable_type: record.class.name,
                   user_id: user.id)

    visit edit_listing_path record
    click_on "Фото"
    click_on "Сделать главной"
    wait_for_ajax

    expect(Picture.first.logo).to eq true
  end
end
