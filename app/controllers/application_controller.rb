class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_devise_tenant, if: :tenantable_devise_action?


  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || 
      if resource_or_scope.is_a?(Tenant::User) or resource_or_scope.is_a?(Tenant::User)
        tenant_root_url(subdomain: resource_or_scope.tenant.subdomain)
      else
        super(resource_or_scope)
      end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, company_attributes: [:id, :company_name]])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, company_attributes: [:company_name, :subdomain, :host]])
    end

    def set_devise_tenant
      if request.subdomains.last
        ActsAsTenant.current_tenant = Admin::Tenant.where(subdomain: request.subdomains.last.downcase).first
      end
    end

    def tenantable_devise_action?
      puts params.inspect
      
      devise_controller? and params[:controller] == 'devise/passwords'
    end

  private
    def layout_by_resource
      if devise_controller?
        "auth/application"
      else
        "application"
      end
    end
end
