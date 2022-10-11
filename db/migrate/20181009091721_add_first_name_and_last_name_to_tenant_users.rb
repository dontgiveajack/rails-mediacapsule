class AddFirstNameAndLastNameToTenantUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :tenant_users, :first_name, :string
    add_column :tenant_users, :last_name, :string
  end
end
