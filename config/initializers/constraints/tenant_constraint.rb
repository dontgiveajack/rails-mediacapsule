class TenantConstraint
  def self.matches?(request)
    Admin::Tenant.find_by(domain: request.host).present?
  end
end
