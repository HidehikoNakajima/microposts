class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.reference :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      t.index[:user_id, :created_at]
    end
  end
end
