class Tenant::MediaItemsController < Tenant::BaseController
  def show
    @resource = Tenant::MediaItem.find(params[:id])

    @current_folder = @resource.folder
    @segments = @current_folder.present? ? @current_folder.path.split('/').select { |s| s.present? } : []
  end

  def create
    @resource = Tenant::MediaItem.new(resource_params)
    @resource.uploader = current_user

    if @resource.save

      if @resource.folder.present?
        respond_smart_with @resource, {}, tenant_catalogue_browser_path(path: @resource.folder.path)
      else
        respond_smart_with @resource, {}, tenant_catalogue_path
      end
    else
      respond_smart_with @resource
    end
  end

  def update
    @resource = Tenant::MediaItem.find(params[:id])

    old_folder = @resource.folder

    if @resource.update(resource_params)
      if resource_params[:is_favourite].nil?
        if params[:is_last_node] == 'true' or params[:is_last_node].nil?
          if old_folder.present?
            respond_smart_with @resource, {}, tenant_catalogue_browser_path(path: old_folder.path)
          else
            respond_smart_with @resource, {}, tenant_catalogue_path
          end
        else
          head :ok # we aren't ready to update the UI yet
        end
      else
        head :ok # we don't need to update the UI
      end
    else
      respond_smart_with @resource
    end
  end

  def move
    @resource = Tenant::MediaItem.find(params[:id])
  end


  def customized_fields_update
    @resource = Tenant::MediaItem.find(params[:id])

    @resource.customized_metadata_fields[params[:name]] = params[:value]
    @resource.save!

    head :ok
  end

  protected
    def resource_params
      ret = params.require(:tenant_media_item).permit(:folder_id, :file, :is_favourite)

      if ret[:is_favourite].nil?
        ret[:folder_id] = nil if ret[:folder_id].to_i == 0
      end

      ret
    end
end
