class AddEmailToRePrivates < ActiveRecord::Migration
  def change
    add_column :re_privates, :email, :string
  end
end
