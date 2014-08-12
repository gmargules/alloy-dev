CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: Settings.aws_access_key_id,
    aws_secret_access_key: Settings.aws_secret_access_key,
    region: 'eu-west-1'
  }
  config.fog_directory = Settings.aws_s3_bucket
end
