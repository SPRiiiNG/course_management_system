class CoursesController < ApplicationController
  before_action :get_nav_data
  before_action :get_courses

  def index
    @course_fields =  ["name", "user", "start_time", "end_time", "capacity"]
    @courses = sort_by_params(@courses) if sort_params.present?
  end

  private

  def today_with(hours, minutes, seconds)
    today = Time.zone.now
    time = today.strftime("%d/%m/%Y #{hours}:#{minutes}")
    Time.zone.parse(time)
  end

  def get_nav_data
    @start_time_query = Time.zone.parse(query_params[:start_time]) rescue nil
    @end_time_query = Time.zone.parse(query_params[:end_time]) rescue nil
    # @start_time = @start_time_query.strftime("%d/%m/%Y %H:%M")
    # @end_time = @end_time_query.strftime("%d/%m/%Y %H:%M")
  end

  def get_courses
    find_params = {}
    if @start_time_query.present?
      @start_time = @start_time_query.strftime("%d/%m/%Y %H:%M")
      find_params[:start_time.gte] = @start_time_query
    end
    if @end_time_query.present?
      @end_time = @end_time_query.strftime("%d/%m/%Y %H:%M")
      find_params[:end_time.lte] = @end_time_query
    end
    find_params[:name] = /(\A#{query_params[:course_name]}|\s#{query_params[:course_name]})/i  if query_params[:course_name].present?
    # asdsad
    @courses = Course.where(find_params)
  end

  def sort_params
    params.require(:sort) rescue nil
  end

  def query_params
    params.permit(:course_name, :start_time, :end_time)
  end

  def sort_by_params(sort_data)
    sort = sort_params.split(':')
    @sort = {}
    @sort['field'] = sort[0]
    @sort['direction'] = sort[1]
    sort_data.order_by([[@sort['field'], @sort['direction']]])
  end
end
