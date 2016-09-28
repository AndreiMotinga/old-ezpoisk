class AddIndexesToVkAndFb < ActiveRecord::Migration[5.0]
  def change
    add_index :jobs, :vk
    add_index :jobs, :fb

    add_index :sales, :vk
    add_index :sales, :fb

    add_index :re_privates, :vk
    add_index :re_privates, :fb
  end
end
