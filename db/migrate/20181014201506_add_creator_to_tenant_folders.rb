class AddCreatorToTenantFolders < ActiveRecord::Migration[5.2]
  def change
    add_reference :tenant_folders, :creator
  end
end
