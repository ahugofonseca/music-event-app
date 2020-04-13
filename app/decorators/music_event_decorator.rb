# frozen_string_literal: true

# Add methods to Music Event
class MusicEventDecorator < Draper::Decorator
  delegate_all

  def scheduled_date
    scheduled_date_time_timezone_converted&.strftime('%m/%d/%Y') ||
      scheduled_date_time.strftime('%m/%d/%Y')
  end

  def scheduled_time
    scheduled_date_time_timezone_converted&.strftime('%H:%M:%S') ||
      scheduled_date_time.strftime('%H:%M:%S')
  end
end
