class Tag < ActiveRecord::Base
  attr_accessible :user_id, :short_url_id, :tag_topic_id

  belongs_to :short_url,
             :class_name => "ShortUrl",
             :foreign_key => :short_url_id,
             :primary_key => :id

end
