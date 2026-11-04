module Coolbelt::Decorator
  extend ActiveSupport::Concern

  include ActionView::Helpers
  include ActionView::Context

  def helper
    Current.view_context
  end

  class_methods do
    def inherited(klass)
      super
      name = klass.name.sub(/Decorator$/, "").underscore
      klass.define_method(name) { __getobj__ }
    end
  end
end
