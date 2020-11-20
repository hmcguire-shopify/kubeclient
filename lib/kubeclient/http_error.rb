# frozen_string_literal: true

# TODO: remove this on next major version bump
# Deprected http exception
class KubeException < StandardError
  attr_reader :error_code
  attr_reader :message
  attr_reader :response

  def initialize(error_code, message, response) # rubocop:disable Lint/MissingSuper
    @error_code = error_code
    @message = message
    @response = response
  end

  def to_s
    string = "HTTP status code #{@error_code}, #{@message}"
    if @response[:request]
      string += " for #{@response[:request][:method]&.to_s&.upcase} #{@response[:request][:url_path]}"
    end
    string
  end
end

module Kubeclient
  # Exception that is raised when a http request fails
  class HttpError < KubeException
  end
end
