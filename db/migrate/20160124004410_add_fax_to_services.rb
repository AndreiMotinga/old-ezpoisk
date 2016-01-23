class AddFaxToServices < ActiveRecord::Migration
  def change
    add_column :services, :fax, :string
  end
end
