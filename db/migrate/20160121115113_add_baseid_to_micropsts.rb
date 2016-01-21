class AddBaseidToMicropsts < ActiveRecord::Migration
  def change
    add_column :microposts, :baseid, :integer
  end
end
