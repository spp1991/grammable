class ApplicationController < ActionController::Base
  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize}", status: :not_found
  end
end
