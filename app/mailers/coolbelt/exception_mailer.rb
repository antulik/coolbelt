class Coolbelt::ExceptionMailer < ::ApplicationMailer
  def notification
    params => exception_group:

    @exception_group = exception_group

    mail(
      to: Coolbelt::RailsPulse.exception_mail_to,
      subject: "[#{Rails.application.name}][#{Rails.env}]#{exception_group.exception_class} #{exception_group.message}",
    )
  end
end
