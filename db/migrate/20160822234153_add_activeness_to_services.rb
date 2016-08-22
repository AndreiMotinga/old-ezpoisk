class AddActivenessToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :active, :boolean
    Service.find_each{|s| s.update_column(:active, true) }
  end
end
