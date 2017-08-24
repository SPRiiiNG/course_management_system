class ApplicationController < ActionController::Base
  include DeviseHelper
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_crumb


protected
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def set_crumb
    add_crumb "CMS", root_path
  end

  def add_crumb(name, url = '')
    @breadcrumbs ||= []
    url = eval(url) if url =~ /_path|_url|@/
    @breadcrumbs << [name, url]
  end
end
