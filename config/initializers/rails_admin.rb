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
  config.excluded_models = ["State", "City", "User"]

  config.model Post do
    include_all_fields
    edit do
      field :text do
        render do
          bindings[:view].render(
            partial: "text",
            locals: { key: text, field: self, form: bindings[:form] }
          )
        end
      end
    end
  end

  config.model "Question" do
    include_all_fields
    configure :tag_list  do
      partial 'tag_list_with_autocomplete'
    end
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

  config.model "Job" do
    include_all_fields
    edit do
      field :description do
        render do
          bindings[:view].render(
            partial: "text",
            locals: { key: :description, field: self, form: bindings[:form] }
          )
        end
      end
    end
  end

  config.model "RePrivate" do
    include_all_fields
    edit do
      field :description do
        render do
          bindings[:view].render(
            partial: "text",
            locals: { key: :description, field: self, form: bindings[:form] }
          )
        end
      end
    end
  end

end
