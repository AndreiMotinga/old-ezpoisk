require "rails_helper"

feature "user updates education" do
  scenario "successfully" do
    user = create_and_login_user
    exp = create :experience, :education, user: user
    attrs = build :experience

    visit edit_user_path(user, act: "education")

    within(:css, "#edit_experience_#{exp.id}") do
      fill_in "Страна", with: attrs.country
      fill_in "Город", with: attrs.city
      fill_in "Школа", with: attrs.name
      fill_in "Специализация", with: attrs.title
      select attrs.start_year, from: "Год начала"
      select attrs.end_year, from: "Год окончания"
      click_on "Сохранить"
    end

    expect(page).to have_content I18n.t(:user_updated)
    user.reload
    expect(user.experiences.size).to eq 1
    exp = user.experiences.first
    expect(exp.kind).to eq "education"
    expect(exp.country).to eq attrs.country
    expect(exp.city).to eq attrs.city
    expect(exp.name).to eq attrs.name
    expect(exp.title).to eq attrs.title
    expect(exp.start_year).to eq attrs.start_year
    expect(exp.end_year).to eq attrs.end_year
  end
end
