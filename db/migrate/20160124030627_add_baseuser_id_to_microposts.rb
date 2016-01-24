class AddBaseuserIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :baseuser_id, :integer
  end
end
