RailsAdmin.config do |config|
  config.current_user_method { current_user }

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

  end
  config.excluded_models = ["State", "City", "User"]

  config.model "Question" do
    include_all_fields
    configure :tag_list  do
      partial 'tag_list_with_autocomplete'
    end
  end
end
