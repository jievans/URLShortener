class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.integer :short_url_id
      t.integer :tag_topic_id

      t.timestamps
    end
  end
end
