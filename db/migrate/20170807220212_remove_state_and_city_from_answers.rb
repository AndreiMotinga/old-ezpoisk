class RemoveStateAndCityFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :state_id
    remove_column :answers, :city_id
  end
end
