class AddSourceToRePrivates < ActiveRecord::Migration
  def change
    add_column :re_privates, :source, :string
  end
end
