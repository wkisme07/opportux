# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Category.all.blank?
  puts "Prepopulate Categories ..."
  Category.create([
    {:code => 'b', :name => 'Business'},
    {:code => 'p', :name => 'People'},
    {:code => 'j', :name => 'Project'}
  ])
end

if City.all.blank?
  puts "Prepopulate Countries ..."
  ActiveRecord::Base.connection.execute "LOAD DATA LOCAL INFILE '#{Rails.root}/db/migrate/GeoWorldMap/Countries.txt' INTO TABLE countries
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;"

  ActiveRecord::Base.connection.execute "LOAD DATA LOCAL INFILE '#{Rails.root}/db/migrate/GeoWorldMap/Regions.txt' INTO TABLE regions
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;"

  puts "Prepopulate Cities ..."
  ActiveRecord::Base.connection.execute "LOAD DATA LOCAL INFILE '#{Rails.root}/db/migrate/GeoWorldMap/Cities.txt' INTO TABLE cities
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;"
end

# admin
if Admin.all.blank?
  puts "Create default admin ..."
  Admin.create(
    :fullname => 'Administrator',
    :email    => 'admin@opportux.com',
    :password => '123oppORtuX',
    :password_confirmation => '123oppORtuX'
  )
end

# content
if Content.all.blank?
  puts "Create default content ..."
  Content.create([
    {
      :code => "howitworks",
      :title => "How It Works",
      :value => "Lorem Ipsum adalah contoh teks atau dummy dalam industri percetakan dan penataan huruf atau typesetting. Lorem Ipsum telah menjadi standar contoh teks sejak tahun 1500an, saat seorang tukang cetak yang tidak dikenal mengambil sebuah kumpulan teks dan mengacaknya untuk menjadi sebuah buku contoh huruf. "
    },{
      :code => "disclaimer",
      :title => "Disclaimer",
      :value => "Lorem Ipsum adalah contoh teks atau dummy dalam industri percetakan dan penataan huruf atau typesetting. Lorem Ipsum telah menjadi standar contoh teks sejak tahun 1500an, saat seorang tukang cetak yang tidak dikenal mengambil sebuah kumpulan teks dan mengacaknya untuk menjadi sebuah buku contoh huruf. "
    },{
      :code => "policy",
      :title => "Policy",
      :value => "Lorem Ipsum adalah contoh teks atau dummy dalam industri percetakan dan penataan huruf atau typesetting. Lorem Ipsum telah menjadi standar contoh teks sejak tahun 1500an, saat seorang tukang cetak yang tidak dikenal mengambil sebuah kumpulan teks dan mengacaknya untuk menjadi sebuah buku contoh huruf. "
    },{
      :code => "term",
      :title => "Terms and Conditions",
      :value => "Lorem Ipsum adalah contoh teks atau dummy dalam industri percetakan dan penataan huruf atau typesetting. Lorem Ipsum telah menjadi standar contoh teks sejak tahun 1500an, saat seorang tukang cetak yang tidak dikenal mengambil sebuah kumpulan teks dan mengacaknya untuk menjadi sebuah buku contoh huruf. "
    }
  ])
end