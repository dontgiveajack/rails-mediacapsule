class AddMetadataFieldsToAdminTenants < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_tenants, :predefined_metadata_fields, :string, array: true
    add_column :admin_tenants, :customized_metadata_fields, :string, array: true
  end
end
