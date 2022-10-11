class Tenant::BaseController < ApplicationController
  include Respondable
  
  set_current_tenant_by_subdomain('admin/tenant'.to_sym, :subdomain)

  before_action :authenticate_user!
end
