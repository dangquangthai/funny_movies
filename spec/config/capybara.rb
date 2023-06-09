if ENV['INTEGRATION_TEST'] == 'true'
  Capybara.register_driver :custom_selenium do |app|
    Capybara::Selenium::Driver.load_selenium
    args = %w[
      headless
      disable-gpu
      window-size=1440,900
    ]
    options = Selenium::WebDriver::Chrome::Options.new(args: args)
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  Capybara.default_max_wait_time = 10 # seconds
  Capybara.enable_aria_label = true
  Capybara.disable_animation = true

  Capybara.app_host = 'http://127.0.0.1:31337'
  Capybara.server_port = 31_337
  Capybara.javascript_driver = :custom_selenium
  
  Capybara.configure do |config|
    config.always_include_port = true
  end

  Rails.application.routes.default_url_options[:host] = Capybara.app_host

  RSpec.configure do |config|
    config.before(:each, type: :system) do
      config.include IntegrationTest::Shared
      driven_by :custom_selenium
    end
  end

  Sidekiq::Testing.inline!
end

RSpec.configure do |config|
  config.before(:all, type: :system) do
    skip unless ENV['INTEGRATION_TEST'] == 'true'
  end
end
