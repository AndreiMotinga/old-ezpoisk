require "rails_helper"

feature "User browses re_finances" do
  scenario "success" do
    visit re_finances_path
    expect(page).to have_content("Расширенный поиск")
  end
end

feature "User browses re_finance" do
  scenario "success" do
    rf = create :re_finance

    visit re_finance_path(rf)

    expect(page).to have_content rf.title
  end
end
