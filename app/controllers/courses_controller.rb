class CoursesController < ApplicationController
  before_action :get_nav_data
  before_action :get_courses, only: :index
  before_action :get_course, only: [:show, :destroy]

  def index
    @course_fields =  ["name", "user", "start_time", "end_time", "capacity"]
    @courses = sort_by_params(@courses)
  end

  def show
  end

  def edit

  end

  def destroy

  end

  protected
  def set_crumb
    super
    add_crumb 'Courses', 'courses_path'
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
    @courses = Course.where(find_params)
  end

  def sort_params
    params.require(:sort) rescue nil
  end

  def query_params
    params.permit(:course_name, :start_time, :end_time)
  end

  def sort_by_params(sort_data)
    sort = sort_params.split(':') rescue ['created_at', 'desc']
    @sort = {}
    @sort['field'] = sort[0]
    @sort['direction'] = sort[1]
    sort_data.order_by([[@sort['field'], @sort['direction']]])
  end

  def course_params
    params.permit(:id)
  end

  def get_course
    @course = Course.find(course_params[:id]) rescue render_not_found
    add_crumb @course.name, course_path(@course)
  end
end
