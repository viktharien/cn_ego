# RSpec.configure do |config|
#
#   config.before(:suite) do
#     DatabaseCleaner.clean_with(:truncation)
#   end
#
#   config.before(:each) do
#     DatabaseCleaner.strategy = :transaction
#   end
#
#   config.before(:each, :js => true) do
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   config.before(:each) do
#     DatabaseCleaner.start
#   end
#
#   config.after(:each) do
#     DatabaseCleaner.clean
#   end
#
# end
#
RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end