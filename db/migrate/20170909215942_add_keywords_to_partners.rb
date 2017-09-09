class AddKeywordsToPartners < ActiveRecord::Migration[5.1]
  def change
    add_column :partners, :keywords, :string
  end
end
