class AddDefaultsToUser < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :phone, ""
    change_column_default :users, :about, ""
    change_column_default :users, :street, ""
    change_column_default :users, :site, ""
    change_column_default :users, :facebook, ""
    change_column_default :users, :google, ""
    change_column_default :users, :vk, ""
    change_column_default :users, :ok, ""
    change_column_default :users, :twitter, ""
  end
end
