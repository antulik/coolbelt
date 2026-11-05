module EmailExceptionPatch
  extend ActiveSupport::Concern

  def upsert_group(fingerprint, location, now)
    pre_status = ::RailsPulse::ExceptionGroup.where(fingerprint:).limit(1).pluck(:status).first

    group = super
    post_status = ::RailsPulse::ExceptionGroup.where(fingerprint:).limit(1).pluck(:status).first

    if pre_status != post_status
      Coolbelt::ExceptionMailer.with(exception_group: group).notification.deliver_later
    end
    group
  end
end

Rails.application.config.after_initialize do
  ::RailsPulse::ExceptionCaptureService.prepend(::EmailExceptionPatch)
end
