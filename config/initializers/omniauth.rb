Devise.setup do |config|
  config.omniauth :open_id, :store => OpenID::Store::Filesystem.new('/tmp'), 
                            :name => 'google', 
                            :identifier => 'https://www.google.com/accounts/o8/id', 
                            :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}},
                            :require => 'omniauth-openid'

  config.omniauth :facebook, ENV['FACEBOOK_SETUPMEETUP_APP_ID'], ENV['FACEBOOK_SETUPMEETUP_SECRET']
  config.omniauth :twitter, ENV['TWITTER_SETUPMEETUP_KEY'], ENV['TWITTER_SETUPMEETUP_SECRET']
  config.omniauth :developer unless Rails.env.production?
end