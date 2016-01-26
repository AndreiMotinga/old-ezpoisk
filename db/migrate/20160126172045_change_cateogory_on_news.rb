class ChangeCateogoryOnNews < ActiveRecord::Migration
  def change
    change_column :posts, :category, :string, :default => "Интересное"
  end
end
