class AddTokenToReCommercial < ActiveRecord::Migration[5.0]
  def change
    add_column :re_commercials, :token, :string
  end
end
