# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!



InitiliazeElasticJob.set(wait: 2.minute).perform_later