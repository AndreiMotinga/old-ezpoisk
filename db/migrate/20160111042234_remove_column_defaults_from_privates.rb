class RemoveColumnDefaultsFromPrivates < ActiveRecord::Migration
  def change
    change_column_default :re_privates, :price, nil
    change_column_default :re_privates, :space, nil
    change_column_default :re_privates, :baths, nil
    change_column_default :re_privates, :rooms, nil
  end
end
