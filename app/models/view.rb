class View < ActiveRecord::Base
  attr_accessible :user_id, :short_url_id

  belongs_to :short_url,
             :class_name => "ShortUrl",
             :foreign_key => :short_url_id,
             :primary_key => :id

  belongs_to :user,
             :class_name => "User",
             :foreign_key => :user_id,
             :primary_key => :id

end
