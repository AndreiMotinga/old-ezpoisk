class AddPaidToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :paid, :boolean, default: false
    add_column :posts, :paid, :boolean, default: false
  end
end
