class AllowAllTheThingsOnForum < ActiveRecord::Migration
  def change
    change_column_default(:forem_topics, :state, 'pending_review')
    change_column_default(:forem_posts, :state, 'pending_review')
    change_column_default(:users, :forem_state, 'pending_review')
  end
end
