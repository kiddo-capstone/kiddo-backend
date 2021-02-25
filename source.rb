require 'aws-sdk'

s3 = Aws::S3::Resource.new(region: 'us-west-2')

my_bucket = s3.bucket('wills-bucket')
my_bucket.create

name = File.basename 'math.png'
obj = s3.bucket('wills-bucket').object(name)
obj.upload_file('math.png')

my_bucket.objects.limit(50).each do |obj|
  puts "  #{obj.key} => #{obj.etag}"
end


Aws::S3::Resource.new(region: 'us-west-2').bucket('wills-bucket').object(name)