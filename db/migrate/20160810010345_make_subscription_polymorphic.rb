class MakeSubscriptionPolymorphic < ActiveRecord::Migration[5.0]
  def change
    remove_column :subscriptions, :question_id
    add_reference :subscriptions, :subscribable, polymorphic: true, index: true
  end
end
