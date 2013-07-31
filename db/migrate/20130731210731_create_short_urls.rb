class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :address
      t.string :long_url_id

      t.timestamps
    end
  end
end
