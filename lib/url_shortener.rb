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
      User.new(:name => user_name, :email => email_string).save!
    rescue => message
      puts message
    end
  end

  def self.shorten(address_string)
    random_id = SecureRandom.urlsafe_base64(6)

    begin
      long_row = LongUrl.find_by_address(address_string)
      unless long_row
        long_row = LongUrl.new(:address  => address_string)
        long_row.save!
      end

      short_url = ShortUrl.new(:address  => random_id,
                               :long_url_id => long_row.id
                               :user_id => @@current_user.id)
      short_url.save!
      random_id
    rescue  => message
      puts message
    end

  end

  def self.expand(short_url)
    short_row = ShortUrl.find_by_address(short_url)
    long_row = short_row.long_url
    Launchy.open( long_row.address )
  end
end
