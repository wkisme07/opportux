class CreateAdvertises < ActiveRecord::Migration
  def change
    create_table :advertises do |t|
      t.string  :size # big, medium, small
      t.string  :title
      t.string  :url
      t.string  :description
      t.string  :image
      t.decimal :price, :default => 0, :precision => 19, :scale => 2
      t.integer :viewed, :default => 0

      t.timestamps
    end
  end
end
