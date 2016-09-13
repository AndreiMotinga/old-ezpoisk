class AddVkAndFbToRePrivates < ActiveRecord::Migration[5.0]
  def change
    add_column :re_privates, :vk, :string, default: ""
    add_column :re_privates, :fb, :string, default: ""
    add_column :sales, :vk, :string, default: ""
    add_column :sales, :fb, :string, default: ""
    add_column :jobs, :vk, :string, default: ""
    add_column :jobs, :fb, :string, default: ""
  end
end
