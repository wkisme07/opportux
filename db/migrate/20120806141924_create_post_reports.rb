class CreatePostReports < ActiveRecord::Migration
  def change
    create_table :post_reports do |t|
      t.integer   :post_id
      t.integer   :user_id
      t.string    :ip_address

      t.timestamps
    end
  end
end
