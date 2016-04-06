class AddImageLinkToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :image_url, :string, default: ""
  end
end
