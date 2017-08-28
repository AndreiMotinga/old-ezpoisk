class AddAnonymousToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :anonymously, :boolean
  end
end
