class Tenant::NodesController < Tenant::BaseController

  def index
    if params[:favourites] == "true"
      @resources = Tenant::Folder.where(is_favourite: true).order(name: :asc) + Tenant::MediaItem.where(is_favourite: true)
    else
      if params[:parent_id].nil? or params[:parent_id].to_i == 0 
        @resources = Tenant::Folder.roots.order(name: :asc) 

        if params[:filter] == 'all' or params[:filter].blank?
          @resources = @resources + Tenant::MediaItem.where(folder_id: nil)
        end
      else
        @current_folder = Tenant::Folder.find(params[:parent_id])
        @resources = @current_folder.children.order(name: :asc) 

        if params[:filter] == 'all' or params[:filter].blank?
          @resources = @resources + @current_folder.media_items
        end
      end
    end
  end

  def move
    @folders = Tenant::Folder.where(id: params[:folder_ids])
    @media_items = Tenant::MediaItem.where(id: params[:media_item_ids])
  end

  def batch_update
    ActiveRecord::Base.transaction do
      new_parent_id = params[:container_id] == '0' ? nil : params[:container_id]

      if params[:tenant_folder_ids].present?
        Tenant::Folder.where(id: params[:tenant_folder_ids]).each do |folder|
          folder.update!(parent_id: new_parent_id)
        end
      end

      if params[:tenant_media_item_ids].present?
        Tenant::MediaItem.where(id: params[:tenant_media_item_ids]).each do |folder|
          folder.update!(folder_id: new_parent_id)
        end
      end
    end

    new_parent = Tenant::Folder.find_by(id: params[:container_id])

    if new_parent.present?
      redirect_to tenant_catalogue_browser_path(path: new_parent.path)
    else
      redirect_to tenant_catalogue_path
    end
  end
end
