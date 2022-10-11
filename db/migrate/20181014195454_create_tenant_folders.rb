class CreateTenantFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :tenant_folders do |t|
      t.string :name
      t.string :ancestry
      t.references :tenant

      t.timestamps
    end
    add_index :tenant_folders, :ancestry
  end
end
