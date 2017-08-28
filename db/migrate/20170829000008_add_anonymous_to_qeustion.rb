class AddAnonymousToQeustion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :anonymously, :boolean
  end
end
