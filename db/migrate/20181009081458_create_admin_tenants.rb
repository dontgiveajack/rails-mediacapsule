class CreateAdminTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_tenants do |t|
      t.string :company_name
      t.string :subdomain
      t.string :domain

      t.timestamps
    end

    add_index :admin_tenants, :subdomain, unique: true
    add_index :admin_tenants, :domain, unique: true
  end
end
