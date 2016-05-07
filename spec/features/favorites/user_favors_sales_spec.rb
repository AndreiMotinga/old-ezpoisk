require "rails_helper"

feature "User favors sales", js: true do
  scenario "user is not logged in" do
    create :sale, :active

    visit sales_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end

  scenario "creates favorite when user is logged in", js: true do
    create_and_login_user
    create :sale, :active

    visit sales_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 1
  end

  scenario "destroys favorite when user is logged in", js: true do
    user = create_and_login_user
    sale = create :sale, :active
    Favorite.create(user_id: user.id,
                    favorable_id: sale.id,
                    favorable_type: sale.class.to_s,
                    favorite: true)

    visit sales_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.where(favorite: true).size).to eq 0
  end
end
