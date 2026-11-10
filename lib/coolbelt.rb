# frozen_string_literal: true

require_relative "coolbelt/version"

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/coolbelt/rails_pulse")
loader.ignore("#{__dir__}/coolbelt/ext")
loader.setup

module Coolbelt
  module RailsPulse
    mattr_accessor :exception_mail_to
  end
  class Error < StandardError; end

  class Engine < ::Rails::Engine
  end
end

