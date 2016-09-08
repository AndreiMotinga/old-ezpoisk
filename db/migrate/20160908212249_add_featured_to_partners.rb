class AddFeaturedToPartners < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :featured, :boolean, default: false
  end
end
