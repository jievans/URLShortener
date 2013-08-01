class ShortUrl < ActiveRecord::Base
  attr_accessible :address, :long_url_id, :user_id

  belongs_to(:long_url,
             :class_name  => "LongUrl",
             :foreign_key  => :long_url_id,
             :primary_key  => :id
             )

    has_many :views,
             :class_name => "View",
             :foreign_key => :short_url_id,
             :primary_key => :id

    has_many :comments,
             :class_name => "Comment",
             :foreign_key => :short_url_id,
             :primary_key => :id

    has_many :users,
             :through => :views,
             :source => :user,
             :uniq => true

end
