Yt.configure do |config|
  config.api_key = Rails.application.secrets[:google_api_key]
end
