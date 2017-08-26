class CoursesController < ApplicationController
  before_action :get_nav_data
  before_action :get_courses, only: [:index]
  before_action :check_authorized, except: [:index, :show]
  before_action :get_course, only: [:edit, :show, :update ,:destroy]
  before_action :get_categories_subjects_hash, only: [:new, :edit]

  def index
    @course_fields =  ["name", "user", "start_time", "end_time", "capacity"]
    @courses = sort_by_params(@courses)
  end

  def my_courses
    get_courses(my_courses: true)
    @course_fields =  ["name", "user", "start_time", "end_time", "capacity"]
    @courses = sort_by_params(@courses)
    add_crumb 'My courses', 'new_course_path'
  end

  def new
    @course = Course.new
    add_crumb 'New', 'my_courses_courses_path'
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user
    if @course.save
      flash[:notice] = "Create #{@course.name} course successfully"
      redirect_to course_path(@course)
    else
      flash[:error] ||= []
      flash[:error] << "Create course failured"
      flash[:error] << @course.errors.full_messages.join(', ')
      get_categories_subjects_hash
      add_crumb 'New', 'new_course_path'
      render :new
    end
  end

  def show
  end

  def edit
    add_crumb 'Edit', 'edit_course_path'
  end

  def update
    subject = Subject.find(course_params[:subject]) rescue nil
    if subject.present? && @course.update(course_params)
      flash[:notice] = "Update course #{@course.name} successfully"
      redirect_to course_path(@course)
    else
      flash.now[:error] ||= []
      flash[:error] << "Update course #{@course.name} failured"
      flash[:error] << @course.errors.full_messages.join(', ')
      get_categories_subjects_hash
      add_crumb 'Edit', 'edit_course_path'
      render :edit
    end
  end

  def destroy
    name = @course.name
    @course.destroy
    flash[:notice] = "Deleted user #{name} successfully"

    redirect_to courses_path
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

  def get_courses(options={})
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
    @courses = options[:my_courses] ? current_user.courses.where(find_params) : Course.where(find_params)
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
    params.require(:course).permit(:subject, :name, :description, :start_time, :end_time, :capacity)
  end

  def get_course
    @course = Course.find(params[:id]) rescue render_not_found
    add_crumb @course.name, course_path(@course)
  end

  def get_categories_subjects_hash
    @categories_subjects_hash = {}
    Category.all.each do |c|
      @categories_subjects_hash[c.id.to_s] =
      {
        'id' => c.id.to_s,
        'name'=> c.name,
        'subjects' => c.subjects.map {|s| {'id' => s.id.to_s, 'name' => s.name }}
      }
    end
  end
end
