class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer   :user_id
      t.integer   :status

      t.string    :title
      t.string    :image
      t.string    :categories

      t.string    :name
      t.string    :email

      t.timestamps
    end
  end
end
