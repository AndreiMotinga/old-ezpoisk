class AddCachedCountersToImpressionableModels < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :impressions_count, :integer, null: false, default: 0
    add_column :posts, :impressions_count, :integer, null: false, default: 0
    add_column :answers, :impressions_count, :integer, null: false, default: 0
    add_column :questions, :impressions_count, :integer, null: false, default: 0
    add_column :users, :impressions_count, :integer, null: false, default: 0
  end
end
