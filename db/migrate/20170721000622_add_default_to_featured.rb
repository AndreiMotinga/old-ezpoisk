class AddDefaultToFeatured < ActiveRecord::Migration[5.1]
  def change
    change_column_default :listings, :featured, false
    change_column_default :listings, :priority, 0
  end
end
