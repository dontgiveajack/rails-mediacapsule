class AddIsFavouriteToTenantFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :tenant_folders, :is_favourite, :boolean, default: false
  end
end
