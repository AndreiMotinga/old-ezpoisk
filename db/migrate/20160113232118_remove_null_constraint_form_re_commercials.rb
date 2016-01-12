class RemoveNullConstraintFormReCommercials < ActiveRecord::Migration
  def change
    change_column :re_commercials, :space, :integer, null: true
  end
end
