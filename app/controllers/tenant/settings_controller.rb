class Tenant::SettingsController < Tenant::BaseController
  helper_method :resource

  def index
  end

  def update
    if ActsAsTenant.current_tenant.update(resource_params)
      if params[:commit_metadata_fields].present?
        respond_smart_with ActsAsTenant.current_tenant, { notice: 'Settings updated successfully' }, "#{tenant_settings_path}#customization"
      else
        respond_smart_with ActsAsTenant.current_tenant, { notice: 'Settings updated successfully' }
      end
    else
      respond_smart_with ActsAsTenant.current_tenant
    end
  end

  def predefined_metadata_fields
    @fields = []

    @fields = ActsAsTenant.current_tenant.predefined_metadata_fields if ActsAsTenant.current_tenant.predefined_metadata_fields.present?
  end

  def customized_metadata_fields
    @fields = []

    @fields = ActsAsTenant.current_tenant.customized_metadata_fields if ActsAsTenant.current_tenant.customized_metadata_fields.present?
  end

  protected
    def resource
      @resource ||= current_user
    end

    def resource_params
      ret = params.require(:settings).permit(predefined_metadata_fields: [], customized_metadata_fields: [])

      if ret[:predefined_metadata_fields].present?
        ret[:predefined_metadata_fields].select! {|f| f.present? }
        ret[:predefined_metadata_fields].uniq!
      end

      if ret[:customized_metadata_fields].present?
        ret[:customized_metadata_fields].select! {|f| f.present? }
        ret[:customized_metadata_fields].uniq!
      end

      ret
    end


end
