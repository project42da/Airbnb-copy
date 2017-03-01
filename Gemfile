source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.1'
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

#Add gems here
gem 'pry-rails', '~> 0.3.4'
gem 'awesome_print', '~> 1.7'
gem 'faker', '~> 1.7', '>= 1.7.3'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'

gem 'devise', '~> 4.2'
gem 'toastr-rails'

gem 'devise-i18n', '~> 0.12.1' #다중언어 서비스 지원시

gem 'omniauth', '~> 1.4', '>= 1.4.1'
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth-google-oauth2', '~> 0.4.1'

gem "font-awesome-rails"

gem "paperclip", "~> 5.0.0"

gem 'geocoder' #영문주소를 좌표값으로 바꿔준다. (굳이 필요없지만 nearbys메서드를 사용하기위해 설치)

gem 'jquery-ui-rails'

gem 'date_validator'#date관련 validate를 쉽게할수 있게해줌...근데 미친 이거왜 또하고있냐 아놔

gem "private_pub"
gem "thin"

gem 'searchkick' #검색기능. location기능이 있는줄 알았다면 DB를 좀더 이쁘게 짰을것이고, geocoder를 안썼을지도 모른다.

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
