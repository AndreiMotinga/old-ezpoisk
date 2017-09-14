class AddSubsToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :subs, :string
  end
end
