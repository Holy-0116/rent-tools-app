class ApplicationController < ActionController::Base  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :keyword

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company_name])
  end

  def keyword
    @p = Item.ransack(params[:q])
  end
end
