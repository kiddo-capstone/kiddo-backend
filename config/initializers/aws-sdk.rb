Aws.config.update(
  credentials: Aws::Credentials.new(ENV['S3_ACCESS_KEY_ID'], ENV['S3_SECRET_ACCESS_KEY']),
  region: 'us-east-1',
)