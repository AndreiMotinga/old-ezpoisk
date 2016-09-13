class AddSocailToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :vk, :string
    add_column :services, :fb, :string
    add_column :services, :google, :string
    add_column :services, :twitter, :string
    add_column :services, :ok, :string
  end
end
