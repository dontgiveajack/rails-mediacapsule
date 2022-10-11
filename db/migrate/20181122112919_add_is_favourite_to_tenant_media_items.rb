class AddIsFavouriteToTenantMediaItems < ActiveRecord::Migration[5.2]
  def change
    add_column :tenant_media_items, :is_favourite, :boolean, default: false
  end
end
