module Coolbelt::Model::Logidze
  extend ActiveSupport::Concern

  def versions
    if log_data.nil?
      reload_log_data
    end

    log_data.versions.reverse.map do |version|
      user = User.find(version.responsible_id) if version.responsible_id

      {
        user:,
        time: Time.zone.at(version.time / 1000),
        changes: version.changes,
      }
    end
  end
end
