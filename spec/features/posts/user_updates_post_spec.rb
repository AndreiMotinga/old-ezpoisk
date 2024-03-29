require "rails_helper"

feature "user updates post", js: true do
  scenario "user updates post" do
    user = create_and_login_user
    record = create :post, user: user, text: "Old Text"
    attrs = build :post

    visit edit_post_path(record)
    fill_in "Заголовок", with: attrs.title
    script = '$(".summernote").summernote("editor.insertText", "New text.");'
    execute_script(script)
    # find("div[contenteditable]").send_keys("New text.")
    select3("законы")
    select3("недвижимость")
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:p_updated)
    record.reload
    expect(record.user).to eq user
    expect(record.title).to eq attrs.title
    expect(record.text).to eq "<p>New text." + "Old Text</p>"
    expect(record.slug).not_to be_empty
    expect(record.cached_tags.split(",")).to match_array %w[работа законы недвижимость]
  end
end
