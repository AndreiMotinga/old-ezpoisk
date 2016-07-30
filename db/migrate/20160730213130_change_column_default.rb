class ChangeColumnDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :re_privates, :baths, nil
  end
end
