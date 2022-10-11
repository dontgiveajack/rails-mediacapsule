class AddAncestryDepthToTenantFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :tenant_folders, :ancestry_depth, :integer, default: 0
  end
end
