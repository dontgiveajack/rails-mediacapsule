module Respondable
  private

  def respond_smart_with(resource, msg = {}, location = nil)
    if resource.respond_to?(:errors) && resource.errors.present?
      case action_name.to_sym
        when :create
          render action: :new
        when :update
          render action: :edit
        when :destroy
          render action: :delete
        else
          render action: :index
      end
    else
      display_name = resource.respond_to?(:display_name) ? resource.display_name : resource.class.model_name.human

      notice = case action_name.to_sym
        when :create
          "#{display_name} has been created."
        when :update
          "#{display_name} has been updated."
        when :destroy
          "#{display_name} has been deleted."
        when /^send/
          "#{display_name} has been sent successfully!"
        else
          "this is a stub flash message"
      end

      respond_to do |format|
        format.html do
          if params[:silent].nil?
            if msg.empty?
              flash[:notice] = notice if (notice and resource.display_name != 'QRID' rescue nil)
            else
              msg.each { |key, value| flash[key] = value }
            end
          end
          if params[:return_path].present? && location.nil?
            redirect_to(params[:return_path])
          else
            redirect_to(location ? location : url_for(controller: controller_name, action: :index))
          end
        end

        format.json do
          if !params[:silent].present? or !(params[:silent] == "true")
            render json: msg.empty? ? { notice: notice } : msg
          else
            render json: {}
          end
        end

        format.js do
          if !params[:silent].present? or !(params[:silent] == "true")
            if msg.empty?
              flash.now[:notice] = notice if notice
            else
              msg.each { |key, value| flash.now[key] = value }
            end
          end

          if location.present?
            redirect_to(location ? location : url_for(controller: controller_name, action: :index))
          end
        end
      end
    end
  end
end
