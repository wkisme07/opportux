class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer   :user_id
      t.string    :slug
      t.integer   :status

      t.string    :title
      t.integer   :category_id
      t.integer   :city_id

      t.text      :description
      t.text      :deal

      t.datetime  :renew
      t.integer   :view, :default => 0
      t.integer   :report, :default => 0

      t.timestamps
    end
  end
end
