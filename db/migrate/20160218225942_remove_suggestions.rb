class RemoveSuggestions < ActiveRecord::Migration
  def change
    drop_table :search_suggestions
  end
end
