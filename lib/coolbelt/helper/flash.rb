module Coolbelt::Helper::Flash
  extend ActiveSupport::Concern

  # Render in application.html.erb
  def turbo_stream_flash
    result = "".html_safe
    if flash.notice
      result << turbo_notice(flash.notice)
    end
    if flash.alert
      result << turbo_alert(flash.alert)
    end
    result
  end

  def turbo_notification(**kw)
    Turbo::StreamsChannel.turbo_stream_action_tag(:notify, **kw)
  end

  def turbo_notice(text, **kw)
    turbo_notification(status: :success, text:, autotimeout: 10_000, **kw)
  end

  def turbo_alert(text, **kw)
    turbo_notification(status: :error, text:, autotimeout: 10_000, **kw)
  end

  def turbo_frame_tag(*, **, &block)
    if turbo_frame_request_id.present? && block
      super do
        str = capture do
          block.call
        end
        (str || "") + turbo_stream_flash
      end
    else
      super
    end
  end
end
