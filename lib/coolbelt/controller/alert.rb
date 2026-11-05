module Coolbelt::Controller::Alert
  extend ActiveSupport::Concern

  def alert(form)
    # if Rails.env.test?
    #   pp(form.errors)
    # end
    flash[:alert] = form.errors.full_messages.join(", ")
  end

  def alert_now(form)
    # if Rails.env.test?
    #   pp(form.errors)
    # end
    flash.now[:alert] = form.errors.full_messages.join(", ")
  end
end
