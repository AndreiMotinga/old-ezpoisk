class MakeApprovedFalseByDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :listings, :approved, false
  end
end
