class AddVisitsToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :re_privates, :visits, :integer, default: 0
    add_column :re_commercials, :visits, :integer, default: 0
    add_column :services, :visits, :integer, default: 0
    add_column :sales, :visits, :integer, default: 0
    add_column :jobs, :visits, :integer, default: 0
    add_column :posts, :visits, :integer, default: 0
    add_column :answers, :visits, :integer, default: 0
    add_column :questions, :visits, :integer, default: 0
  end
end
