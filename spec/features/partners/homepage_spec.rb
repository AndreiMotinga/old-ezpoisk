require "rails_helper"

feature "partner is charged" do
  scenario "when visited once" do
    partner_top = create :partner
    partner_bottom = create :partner, position: :bottom
    page = create :page
    PartnerPage.create(partner: partner_top, page: page)
    PartnerPage.create(partner: partner_bottom, page: page)

    visit root_path

    partner_top.reload
    partner_bottom.reload
    expect(partner_top.current_balance).to eq 1
    expect(partner_bottom.current_balance).to eq 1
  end


  scenario "when visited twice" do
    partner_top = create :partner
    partner_bottom = create :partner, position: :bottom
    page = create :page
    PartnerPage.create(partner: partner_top, page: page)
    PartnerPage.create(partner: partner_bottom, page: page)

    visit root_path
    visit root_path

    partner_top.reload
    partner_bottom.reload
    expect(partner_top.current_balance).to eq 2
    expect(partner_bottom.current_balance).to eq 2
  end
end
