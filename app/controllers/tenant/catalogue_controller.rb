class Tenant::CatalogueController < Tenant::BaseController
  def index
    if params[:path].present?
      navigate_path
    else
      @segments = []
    end

    @media_item = @current_folder.present? ? Tenant::MediaItem.new(folder: @current_folder) : Tenant::MediaItem.new
  end


  protected
    def navigate_path
      @segments = params[:path].split('/').select { |s| s.present? }

      @current_folder = nil

      @segments.each do |segment|
        if @current_folder.nil?
          # we're still at the root
          @current_folder = Tenant::Folder.roots.where(name: segment).first

          raise ActionController::RoutingError.new('Not Found') if @current_folder.nil?
        else
          # we're deeper in the tree
          @current_folder = @current_folder.children.where(name: segment).first

          raise ActionController::RoutingError.new('Not Found') if @current_folder.nil?
        end
      end
    end
end
