module Coolbelt::Controller::LayoutChain
  extend ActiveSupport::Concern

  included do
    class_attribute :custom_layout_name
    layout :layout_name
  end

  def layout_name
    turbo_frame_request? ? "turbo_rails/frame" : custom_layout_name
  end

  class_methods do
    def set_layout(**kw, &)
      before_action(**kw) do
        result = instance_exec(&)
        self.custom_layout_name = result if result
      end
    end
  end
end

