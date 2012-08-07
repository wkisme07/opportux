class AddSlugToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :slug, :string

    User.all.each do |u|
      u.slug = Digest::SHA1.hexdigest(u.email.to_s).slice(0, 8)
      puts = "-----: #{u.save!} : #{u.email} "
    end
  end

  def self.down
    remove_column :users, :slug
  end
end
