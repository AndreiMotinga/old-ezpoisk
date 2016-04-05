class AddEmailToReCommercials < ActiveRecord::Migration
  def change
    add_column :re_commercials, :email, :string
  end
end
