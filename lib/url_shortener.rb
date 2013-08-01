class Shortener

  def self.login(email_string)
    user_row = User.find_by_email(email_string)
    if user_row
      @@current_user = user_row
    else
      puts "User does not exist."
    end
  end

  def self.create_account(user_name, email_string)
    begin
      User.new(:name => user_name,
               :email => email_string).save!
    rescue => message
      puts message
    end
  end

  def self.shorten(address_string)
    random_id = SecureRandom.urlsafe_base64(6)

    begin
      long_row = LongUrl.find_by_address(address_string)
      unless long_row
        long_row = LongUrl.new(:address => address_string)
        long_row.save!
      end

      short_url = ShortUrl.new(:address => random_id,
                               :long_url_id => long_row.id,
                               :user_id => @@current_user.id)
      short_url.save!
      random_id
    rescue  => message
      puts message
    end
  end

  def self.expand(short_url)
    short_row = ShortUrl.find_by_address(short_url)
    begin
      View.new(:user_id => @@current_user.id,
               :short_url_id => short_row.id).save!
    rescue => message
      puts message
    end
    long_row = short_row.long_url
    short_row.comments.each do |comment|
      puts comment.body
    end
    Launchy.open( long_row.address )
  end

  def self.uniques(short_url)
    ShortUrl.find_by_address(short_url).users.count
  end

  def self.views(short_url)
    ShortUrl.find_by_address(short_url).views.count
  end

  def self.last_ten_min_views(short_url)
    ShortUrl.find_by_address(short_url).views.select do |view_row|
      Time.now.to_i - view_row.created_at.to_i < 10 * 60
    end.count
  end

  def self.comment(short_url, body)
    short_id = ShortUrl.find_by_address(short_url).id
    Comment.new(:body => body,
                :short_url_id => short_id,
                :user_id => @@current_user.id).save!
  end

  def self.tag(short_url, topic)
    short_id = ShortUrl.find_by_address(short_url).id
    tag_id = TagTopic.find_by_topic(topic).id
    Tag.new(:user_id => @@current_user.id,
            :short_url_id => short_id,
            :tag_topic_id => tag_id).save!
  end

  def self.create_tag(topic)
    TagTopic.new(:topic => topic).save!
  end

  def self.most_popular_url_for_tag(tag)
    short_frequency = Hash.new(0)
    TagTopic.find_by_topic(tag).short_urls.each do |short_row|
      short_frequency[short_row.id] += 1
    end
    max_array = short_frequency.max_by { |id, frequency| frequency }
    puts ShortUrl.find_by_id(max_array.first).address
  end

end



