require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test? # 演算子|| aかbの少なくとも1つが真の場合に真 つまり開発かテストならtrue falseならfog(S3)へ保存
    config.storage = :file
  elsif Rails.env.production? #本番はS3に保存する
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',     #AWSのアクセスキーとシークレットキーを環境変数で定義する
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id], #credentails.ymlに鍵の本体があります
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],  #credentails.ymlに鍵の本体があります
      region: 'ap-northeast-1'
    }
    config.fog_directory  = 'f70-team-d'
    config.asset_host = 'https://f70-team-d.s3.amazonaws.com'
  end
end