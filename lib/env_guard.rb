require "env_guard/version"
require 'active_support/concern'
require 'active_support/security_utils'

module EnvGuard
  extend ActiveSupport::Concern

  included do
    private

    def environment_guard_flags?
      ENV['ENVGUARD_USERNAME'].present?
    end

    def guard_environment
      return session[:authenticated_for_environment_guard] if session[:authenticated_for_environment_guard]

      if ENV['ENVGUARD_USERNAME'].blank? || ENV['ENVGUARD_PASSWORD'].blank?
        raise ArgumentError, "Must set the ENV variables ENVGUARD_USERNAME and ENVGUARD_PASSWORD"
      end

      authenticate_or_request_with_http_basic("Application") do |name, password|
        granted = ActiveSupport::SecurityUtils.variable_size_secure_compare(name, (ENV['ENVGUARD_USERNAME'].presence)) &
          ActiveSupport::SecurityUtils.variable_size_secure_compare(password, (ENV['ENVGUARD_PASSWORD'].presence))
        session[:authenticated_for_environment_guard] = granted
        granted
      end
    end
  end
end
