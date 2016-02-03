class AddstreetToSales < ActiveRecord::Migration
  def change
    add_column :sales, :street, :string,  defatul: ''
  end
end
