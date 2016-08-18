class AddTokenToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :token, :string
  end
end
