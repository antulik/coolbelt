module Coolbelt::HasTimeRange
  extend ActiveSupport::Concern

  module TimeParser
    def self.parse_time_text(value)
      return if value.blank?

      parsed_time = Time.strptime(value.to_s, "%H:%M") # parse in any time zone
      h = parsed_time.hour
      m = parsed_time.min
      s = m == 59 ? 59 : 0
      h.hours + m.minutes + s.seconds
    rescue ArgumentError
      nil
    end

    def self.format_time_text(seconds)
      Time.at(seconds).utc.strftime("%H:%M") if seconds
    end
  end

  class_methods do
    def has_time_range
      class_eval do
        attribute(:start_seconds, :integer, default: 0)
        attribute(:end_seconds, :integer, default: 86_399)

        validates(:start_seconds, :end_seconds, presence: true,
          numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 86_400 },)
        validates(:end_seconds, comparison: { greater_than: :start_seconds })

        after_validation do
          errors.add(:start_time_text, :invalid) if errors[:start_seconds].present?
          errors.add(:end_time_text, :invalid) if errors[:end_seconds].present?
        end

        def start_time_text
          TimeParser.format_time_text(start_seconds)
        end

        def end_time_text
          TimeParser.format_time_text(end_seconds)
        end

        def start_time_utc = Time.at(start_seconds).utc
        def end_time_utc = Time.at(end_seconds).utc

        def seconds_includes?(second)
          start_seconds <= second && second <= end_seconds
        end

        def start_time(datetime)
          time = start_time_utc
          datetime.change({ hour: time.hour, min: time.min, sec: time.sec })
        end

        def end_time(datetime)
          time = end_time_utc
          datetime.change({ hour: time.hour, min: time.min, sec: time.sec })
        end

        def start_time_text=(value)
          self.start_seconds = TimeParser.parse_time_text(value)
        end

        def end_time_text=(value)
          self.end_seconds = TimeParser.parse_time_text(value)
        end
      end
    end
  end
end
