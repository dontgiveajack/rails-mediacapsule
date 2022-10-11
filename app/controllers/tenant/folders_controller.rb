class Tenant::FoldersController < Tenant::BaseController
  def new
    @resource = Tenant::Folder.new
  end

  def edit
  end

  def create
    parent = params[:parent_id].to_i == 0 ? nil : Tenant::Folder.find(params[:parent_id])

    @resource = Tenant::Folder.new(resource_params)
    @resource.parent = parent
    @resource.creator = current_user

    if @resource.save
      if parent.present?
        respond_smart_with @resource, {}, tenant_catalogue_browser_path(path: parent.path)
      else
        respond_smart_with @resource, {}, tenant_catalogue_path
      end
    else
      respond_smart_with @resource
    end
  end

  def destroy
  end

  def update
    @resource = Tenant::Folder.find(params[:id])

    old_parent = @resource.parent

    if @resource.update(resource_params)

      puts resource_params.inspect

      if resource_params[:is_favourite].nil?
        if old_parent.present?
          respond_smart_with @resource, {}, tenant_catalogue_browser_path(path: old_parent.path)
        else
          respond_smart_with @resource, {}, tenant_catalogue_path
        end
      else
        head :ok # don't do anything
      end
    else
      respond_smart_with @resource
    end
  end

  def move
    @resource = Tenant::Folder.find(params[:id])
  end

  protected
    def resource_params
      ret = params.require(:tenant_folder).permit(:name, :parent_id, :is_favourite)

      if ret[:is_favourite].nil?
        ret[:parent_id] = nil if ret[:parent_id].to_i == 0
      end

      ret
    end
end
