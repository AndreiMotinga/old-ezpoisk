class AddSourceToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :source, :string
  end
end
