class TagTopic < ActiveRecord::Base
  attr_accessible :topic

  has_many :tags,
           :class_name => "Tag",
           :foreign_key => :tag_topic_id,
           :primary_key => :id

  has_many :short_urls,
           :through => :tags,
           :source => :short_url
end
