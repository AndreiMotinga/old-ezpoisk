class AllowAllTheThingsForRealOnForem < ActiveRecord::Migration
  def change
    change_column_default(:forem_topics, :state, 'approved')
    change_column_default(:forem_posts, :state, 'approved')
    change_column_default(:users, :forem_state, 'approved')
  end
end
