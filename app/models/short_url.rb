class ShortUrl < ActiveRecord::Base
  attr_accessible :address, :long_url_id, :user_id

  belongs_to(:long_url,
             :class_name  => "LongUrl",
             :foreign_key  => :long_url_id,
             :primary_key  => :id
             )
end
