class RemoveImpresstions < ActiveRecord::Migration[5.0]
  def change
    remove_column :answers, :impressions_count
    remove_column :answers, :visits

    remove_column :listings, :impressions_count
    remove_column :listings, :visits

    remove_column :questions, :impressions_count
    remove_column :questions, :visits

    remove_column :users, :impressions_count
  end
end
