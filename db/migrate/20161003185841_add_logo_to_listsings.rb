class AddLogoToListsings < ActiveRecord::Migration[5.0]
  def change
    add_column :re_privates, :logo_url, :string, default: "https://s3.amazonaws.com/ezpoisk/missing-small.png"
    add_column :sales, :logo_url, :string, default: "https://s3.amazonaws.com/ezpoisk/missing-small.png"
    add_column :services, :logo_url, :string, default: "https://s3.amazonaws.com/ezpoisk/missing-small.png"
  end
end
