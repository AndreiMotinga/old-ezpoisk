class ChangeApprovedDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :listings, :approved, true
  end
end
