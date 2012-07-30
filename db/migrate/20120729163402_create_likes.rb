class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer   :post_id
      t.integer   :user_id
      t.string    :ip_address

      t.timestamps
    end
  end
end
