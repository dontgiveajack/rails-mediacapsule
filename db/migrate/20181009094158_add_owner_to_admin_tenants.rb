class AddOwnerToAdminTenants < ActiveRecord::Migration[5.2]
  def change
    add_reference :admin_tenants, :owner
  end
end
