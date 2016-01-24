class AddBaseuserNameToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :baseuser_name, :string
  end
end
