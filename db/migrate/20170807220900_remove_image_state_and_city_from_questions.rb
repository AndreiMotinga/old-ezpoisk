class RemoveImageStateAndCityFromQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :state_id
    remove_column :questions, :city_id
    remove_column :questions, :image_url
  end
end
