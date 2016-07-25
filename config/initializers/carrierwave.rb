if Rails.env.production?
CarrierWave.configure do |config|
config.fog_credentials = {
:provider => 'AWS',
:aws_access_key_id => 'a',
:aws_secret_access_key => 'b',
:region => "Ireland"
}
config.fog_directory = 'c'
end
end
