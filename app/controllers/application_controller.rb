class ApplicationController < ActionController::Base
  layout :layout_by_resource

  protected

  def layout_by_resource
    devise_controller? ? "#{resource_class.to_s.downcase}_devise" : "#{resource_class.to_s.downcase}"
  end
  
end
