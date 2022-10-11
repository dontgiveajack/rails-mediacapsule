class AddFolderSizeToTenantFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :tenant_folders, :folder_size, :bigint, default: 0
  end
end
