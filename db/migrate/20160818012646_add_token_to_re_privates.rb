class AddTokenToRePrivates < ActiveRecord::Migration[5.0]
  def change
    add_column :re_privates, :token, :string
  end
end
