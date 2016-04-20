class AddPageToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :page, :string
  end
end
