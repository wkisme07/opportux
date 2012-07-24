class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer   :user_id
      t.integer   :status

      t.string    :title
      t.integer   :category_id
      t.integer   :city_id

      t.text      :description
      t.text      :description_2

      t.timestamps
    end
  end
end
