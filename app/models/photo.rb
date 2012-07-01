class Photo < ActiveRecord::Base
  def self.random
    random_index = rand(aws_s3_bucket.files.length)
    aws_s3_bucket.files[random_index].public_url
  end

  def self.aws_s3_bucket
    connection.directories.get("918photos")
  end

  def self.connection
    Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => ENV['AWS_PUBLIC'],
      :aws_secret_access_key    => ENV['AWS_SECRET']
    })
  end
end
