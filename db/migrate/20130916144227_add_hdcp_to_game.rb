class AddHdcpToGame < ActiveRecord::Migration
  def change
    add_column :games, :hdcp, :integer
  end
end
