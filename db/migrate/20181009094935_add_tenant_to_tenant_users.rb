class AddTenantToTenantUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :tenant_users, :tenant
  end
end
