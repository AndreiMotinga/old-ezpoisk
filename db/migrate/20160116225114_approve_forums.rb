class ApproveForums < ActiveRecord::Migration
  def change
    change_column :forem_topics, :state, :string, :default => 'approved', :null => false
  end
end
