class RemoveImageFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_attachment :answers, :image
  end
end
