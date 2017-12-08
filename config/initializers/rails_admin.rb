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
    "Comment",
    "Experience",
    "Listing",
    "Partner",
    "Picture",
    "Post",
    "Question",
    "User",
    "City",
    "State"
  ]
end
