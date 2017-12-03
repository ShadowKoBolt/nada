source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'acts-as-taggable-on', '~> 4.0'
gem 'aws-sdk'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'coffee-rails', '~> 4.2'
gem 'country_select'
gem 'devise'
gem 'figaro'
gem 'friendly_id', '~> 5.1.0'
gem 'geocoder'
gem 'gmaps4rails'
gem 'high_voltage'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'meta-tags'
gem 'money'
gem 'newrelic_rpm'
gem 'paperclip', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'pg_search'
gem 'plyr-rails'
gem 'puma', '~> 3.7'
gem 'pundit'
gem 'rails', '~> 5.1.3'
gem 'reform-rails'
gem 'sass-rails', '~> 5.0'
gem 'slim'
gem 'stripe'
gem 'uglifier', '>= 1.3.0'
gem 'yt'
gem 'yt-url'

group :development, :test do
  gem 'pry-rails'
  gem 'letter_opener'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
