class AddImpressionsCountToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :impressions_count, :integer, default: 0
  end
end
