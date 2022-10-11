class Tenant::DashboardController < Tenant::BaseController
  def index

    all_attachments = ActiveStorage::Attachment.where(record_type: 'Tenant::MediaItem', record_id: Tenant::MediaItem.all.pluck(:id))

    @used_storage = all_attachments.inject(0) { |sum, a| sum + a.blob.byte_size }
  end
end
