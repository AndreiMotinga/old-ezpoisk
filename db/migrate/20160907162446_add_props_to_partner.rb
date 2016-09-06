class AddPropsToPartner < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :budget, :string
    add_column :partners, :phone, :string
    add_column :partners, :email, :string
  end
end
