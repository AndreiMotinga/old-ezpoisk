class AddKindToPartner < ActiveRecord::Migration[5.1]
  def change
    add_column :partners, :kind, :string
  end
end
