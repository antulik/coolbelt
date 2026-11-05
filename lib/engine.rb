require "coolbelt"

module Coolbelt
  module RailsPulse
    mattr_accessor :exception_mail_to
  end

  class Engine < ::Rails::Engine
  end
end
