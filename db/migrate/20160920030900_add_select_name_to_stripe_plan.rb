class AddSelectNameToStripePlan < ActiveRecord::Migration[5.0]
  def change
    add_column :stripe_plans, :select_name, :string
  end
end
