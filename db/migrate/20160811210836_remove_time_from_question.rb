class RemoveTimeFromQuestion < ActiveRecord::Migration[5.0]
  def change
    remove_column :questions, :created_at
    remove_column :questions, :updated_at
  end
end
