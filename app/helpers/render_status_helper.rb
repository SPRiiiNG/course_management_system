module RenderStatusHelper
  protected
  def render_ok(message = "OK", options = {})
    render json: {message: message}.merge!(options), status: :ok
  end

  def render_created(message = "Created", options = {})
    render json: {message: message}.merge!(options), status: :created
  end

  def render_unauthorized(message = "Bad credentials", options = {})
    render json: {message: message}.merge!(options), status: :unauthorized
  end

  def render_bad_request(message = "Bad request", options = {})
    render json: {message: message}.merge!(options), status: :bad_request
  end

  def render_forbidden(message = "Forbidden", options = {})
    respond_to do |format|
      format.any(:html, :xml, :csv) do
        render file: "#{Rails.root}/public/403", layout: false, status: :forbidden
      end

      format.json do
        render json: {message: message}.merge!(options), status: :forbidden
      end
    end
  end

  def render_not_found(message = "Not found", options = {})
    respond_to do |format|
      format.any(:html, :xml, :csv, :xlsx) do
        render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      end

      format.json do
        render json: {message: message}.merge!(options), status: :not_found
      end
    end
  end

  def render_internal_server_error(message = "Internal server error", options = {})
    respond_to do |format|
      format.any(:html, :xml, :csv) do
        render file: "#{Rails.root}/public/500", layout: false, status: :internal_server_error
      end

      format.json do
        render json: {message: message}.merge!(options), status: :internal_server_error
      end
    end
  end
end
