class ChangeShortUrlsLongUrlId < ActiveRecord::Migration
  def up
    change_table :short_urls do |t|
      t.change :long_url_id, :integer
    end
  end

  def down
    change_table :short_urls do |t|
      t.change :long_url_id, :string
    end
  end
end
