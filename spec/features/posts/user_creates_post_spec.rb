require "rails_helper"

feature "user creates post", js: true do
  scenario "user creates job" do
    user = create_and_login_user
    attrs = build :post

    visit new_post_path
    fill_in "Заголовок", with: attrs.title
    script = '$(".summernote").summernote("editor.insertText", "New text.");'
    execute_script(script)
    # find('div[contenteditable]').send_keys('This is awesome blog.')
    select3("работа")
    select3("недвижимость")
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:p_created)
    saved_post = user.posts.last
    expect(saved_post.title).to eq attrs.title
    expect(saved_post.text).to eq "<p>New text.<br></p>"
    expect(saved_post.slug).not_to be_empty
    expect(saved_post.cached_tags.split(",")).to match_array %w[недвижимость работа]
  end
end
