class User < ActiveRecord::Base
  attr_accessible :name, :email

  has_many :views,
           :class_name => "View",
           :foreign_key => :user_id,
           :primary_key => :id

  has_many :viewed_short_urls,
           :through => :views,
           :source => :short_url

  has_many :short_urls,
           :class_name => "ShortUrl",
           :foreign_key => :user_id,
           :primary_key => :id

end
