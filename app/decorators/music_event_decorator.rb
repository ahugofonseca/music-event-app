# frozen_string_literal: true

# Add methods to Music Event
class MusicEventDecorator < Draper::Decorator
  delegate_all

  def scheduled_date
    factory_schedule_date_time.strftime('%m/%d/%Y')
  end

  def scheduled_time
    factory_schedule_date_time.strftime('%H:%M:%S')
  end

  private

  def factory_schedule_date_time
    return scheduled_date_time_timezone_converted if object.respond_to?(
      :scheduled_date_time_timezone_converted
    )

    scheduled_date_time
  end
end
