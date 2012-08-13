class AddContactToAdvertises < ActiveRecord::Migration
  def change
    add_column :advertises, :business_name, :string
    add_column :advertises, :contact_name, :string
    add_column :advertises, :contact_email, :string
  end
end
