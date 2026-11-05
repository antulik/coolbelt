module Coolbelt::Helper::Form
  extend ActiveSupport::Concern

  def form_with(**kw, &block)
    kw[:html] ||= {}
    kw[:html][:autocomplete] ||= "off"

    super(**kw, &block)
  end

  def turbo_frame_tag_wrap(except: nil, &block)
    except = Array.wrap(except).map(&:to_s)
    if turbo_frame_request_id.present? && except.exclude?(turbo_frame_request_id)
      turbo_frame_tag(turbo_frame_request_id, &block)
    else
      capture(&block)
    end
  end

  def random_id
    "x" + SecureRandom.hex
  end

  # only render content if the turbo frame is active
  def active_turbo_frame_tag(id, ...)
    if turbo_frame_request_id == id.to_s
      turbo_frame_tag(id, ...)
    else
      turbo_frame_tag(id)
    end
  end
end
