RailsAdmin.config do |config|
  config.authorize_with :cancan
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
  config.excluded_models = ["State", "City", "Horoscope", "User"]

  config.model Post do
    include_all_fields
    edit do
      field :body do
        render do
          bindings[:view].render partial: "body",
            locals: { field: self, form: bindings[:form] }
        end
      end
    end
  end
end
