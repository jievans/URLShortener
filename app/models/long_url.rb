class LongUrl < ActiveRecord::Base
  attr_accessible :address

  has_many( :short_urls,
            :class_name  => "ShortUrls",
            :foreign_key  => :long_url_id,
            :primary_key  => :id)

  validates :address, :uniqueness  => true
end
