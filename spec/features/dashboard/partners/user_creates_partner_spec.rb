require "rails_helper"

feature "user creates partner" do
  scenario "successfully", js: true do
    # state = create :state, :alabama
    user = create_and_login_user

    visit new_dashboard_partner_path
    partner = build(:partner)

    fill_in "Название", with: partner.title
    fill_in "Ссылка", with: partner.link
    select(partner.position, from: "Позиция")
    select(partner.page, from: "Страница")
    # select(state.name, from: "Штат")
    attach_file("Банер", Rails.root + "spec/support/fixtures/top.jpg")

    click_on "Сохранить"

    expect(page).to have_content partner.title
    p = Partner.last
    expect(p.title).to eq partner.title
    expect(p.link).to eq partner.link
    expect(p.start_date).to be nil
    expect(p.active_until).to be nil

    expect(p.position).to eq partner.position
    expect(p.page).to eq partner.page

    # expect(p.state_id).to_not be nil
    expect(p.user).to_not be user
  end
end
