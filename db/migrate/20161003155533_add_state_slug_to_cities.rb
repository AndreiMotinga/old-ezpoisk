class AddStateSlugToCities < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :state_slug, :string, index: true
    State.find_each do |state|
      state.cities.update_all(state_slug: state.slug)
    end
  end
end
