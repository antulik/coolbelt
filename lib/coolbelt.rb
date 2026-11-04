# frozen_string_literal: true

require_relative "coolbelt/version"

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/coolbelt/rails_pulse")
loader.setup

module Coolbelt
  class Error < StandardError; end

end

