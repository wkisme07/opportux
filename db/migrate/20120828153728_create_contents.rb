class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :code
      t.string :title
      t.text :value

      t.timestamps
    end
  end
end
