class AddStateAndCitySlugToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :state_slug, :string, index: true
    add_column :users, :city_slug, :string, index: true
    User.find_each do |u|
      u.update_column(:state_slug, State.find(u.state_id).slug) if u.state_id
      u.update_column(:city_slug, City.find(u.city_id).slug) if u.city_id
    end
  end
end

