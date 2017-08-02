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

  config.included_models = [
    "Action",
    "ActsAsTaggableOn::Tag",
    "Answer",
    "Listing",
    "Picture",
    "Question",
    "User"
  ]

  config.model "Answer" do
    include_all_fields
    edit do
      field :text do
        render do
          bindings[:view].render(
            partial: "text",
            locals: { key: :text, field: self, form: bindings[:form] }
          )
        end
      end
    end
  end
end
