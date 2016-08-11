class AddSlugToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :slug, :string, index: true
  end
end
