class AddLogoUrlToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :logo_url, :string
  end
end
