class AddMetadataFieldsToTenantMediaItems < ActiveRecord::Migration[5.2]
  def change
    add_column :tenant_media_items, :predefined_metadata_fields, :jsonb
    add_column :tenant_media_items, :customized_metadata_fields, :jsonb
  end
end
