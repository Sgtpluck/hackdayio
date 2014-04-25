OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yammer, 'key', 'secret'
  provider :github, 'key', 'secret'
end
