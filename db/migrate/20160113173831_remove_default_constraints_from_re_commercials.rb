class RemoveDefaultConstraintsFromReCommercials < ActiveRecord::Migration
  def change
    change_column_default :re_commercials, :price, nil
    change_column_default :re_commercials, :space, nil
  end
end
