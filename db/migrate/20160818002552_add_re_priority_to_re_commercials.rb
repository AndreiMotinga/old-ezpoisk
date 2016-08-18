class AddRePriorityToReCommercials < ActiveRecord::Migration[5.0]
  def change
    add_column :re_commercials, :priority, :integer, default: 0, null: false
  end
end
