# frozen_string_literal: true

require_relative "coolbelt/version"

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

module Coolbelt
  class Error < StandardError; end
  # Your code goes here...
end
