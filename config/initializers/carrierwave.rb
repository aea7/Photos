CarrierWave.configure do |config|
config.fog_credentials = {
:provider => 'AWS',
:aws_access_key_id => 'AKIAJRWCT5GH2S4UZEXQ',
:aws_secret_access_key => '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'
}
config.fog_directory = 'aak-rails'
end
