class DropDog < ActiveRecord::Migration
  def change
    drop_table :grumpy_dogs
  end
end
