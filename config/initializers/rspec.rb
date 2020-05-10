# frozen_string_literal: true

Rails.application.config.generators do |g|
  g.test_framework :rspec
  g.integration_tool :rspec
end
