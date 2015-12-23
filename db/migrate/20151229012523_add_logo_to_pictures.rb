class AddLogoToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :logo, :boolean
  end
end
