class CoursesController < ApplicationController

  def index
    # courses = Courses.where(
    #   :start_time.gte => @start_time_query,
    #   :start_time.lte => @end_time_query
    # )
    courses = Course.where(
      start_time: @start_time_query,
      start_time: @end_time_query
    )
  end

  private

  def today_with(hours, minutes, seconds)
    today = Time.zone.now
    time = today.strftime("%d/%m/%Y #{hours}:#{minutes}")
    Time.zone.parse(time)
  end

  def get_nav_data
    @start_time_query = Time.zone.parse(query_params[:start_time]) rescue today_with(8,0,0)
    @end_time_query = Time.zone.parse(query_params[:end_time]) rescue today_with(20,0,0)
    @start_time = @start_time_query.strftime("%d/%m/%Y %H:%M")
    @end_time = @end_time_query.strftime("%d/%m/%Y %H:%M")
  end

  def date_params
    params.permit(:start_time, :end_time)
  end
end
