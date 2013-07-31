class CreateLongUrls < ActiveRecord::Migration
  def change
    create_table :long_urls do |t|
      t.string :address

      t.timestamps
    end
  end
end
