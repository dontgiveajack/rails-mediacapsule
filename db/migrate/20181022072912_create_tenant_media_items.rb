class CreateTenantMediaItems < ActiveRecord::Migration[5.2]
  def change
    create_table :tenant_media_items do |t|
      t.references :folder
      t.references :tenant
      t.references :uploader
      t.boolean :archived
      t.boolean :online

      t.timestamps
    end
  end
end
