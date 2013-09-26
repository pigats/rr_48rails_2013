# config/initializers/koala.rb
# Simple approach
Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    raise "application id and/or secret are not specified in the envrionment" unless ENV['API_KEY'] && ENV['APP_SECRET']
    initialize_without_default_settings(ENV['API_KEY'].to_s, ENV['APP_SECRET'].to_s, args.first)
  end 

  alias_method_chain :initialize, :default_settings 
end