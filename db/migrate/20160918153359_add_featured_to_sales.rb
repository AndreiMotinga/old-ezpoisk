class AddFeaturedToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :featured, :boolean, default: false
    add_column :jobs, :featured, :boolean, default: false
    add_column :re_privates, :featured, :boolean, default: false
  end
end
