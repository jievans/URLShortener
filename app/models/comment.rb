class Comment < ActiveRecord::Base
  attr_accessible :user_id, :short_url_id, :body
end
