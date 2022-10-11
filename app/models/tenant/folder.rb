# == Schema Information
#
# Table name: tenant_folders
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  ancestry       :string
#  tenant_id      :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  creator_id     :bigint(8)
#  folder_size    :bigint(8)        default(0)
#  ancestry_depth :integer          default(0)
#

class Tenant::Folder < ApplicationRecord
  acts_as_tenant(:tenant, foreign_key: 'tenant_id', class_name: 'Admin::Tenant')
  has_ancestry cache_depth: true

  belongs_to :creator, class_name: 'Tenant::User', foreign_key: 'creator_id'

  has_many :media_items, dependent: :destroy

  validates :name, presence: true

  validate :unique_name_amongst_siblings

  after_update_commit do
    if self.previous_changes["ancestry"].present? and self.folder_size > 0

      puts "CHANGED!!!!"
      # just redo the whole thing :((((
      Tenant::Folder.all.update_all(folder_size: 0)

      Tenant::MediaItem.all.each do |media_item|
        if media_item.folder_id.present? and media_item.file.attachment.present?
          subject_folder = media_item.folder

          subject_folder.update_columns(folder_size: subject_folder.folder_size + media_item.file.byte_size)

          subject_folder.ancestors.each do |ancestor|
            ancestor.update_columns(folder_size: ancestor.folder_size + media_item.file.byte_size)
          end
        end
      end
    end
  end

  def path
    result = ''

    self.ancestors.each_with_index do |ancestor, i|

      if i == 0
        result = "#{ancestor.name}"
      else
        result = "#{result}/#{ancestor.name}"
      end
    end

    if result.blank?
      result = self.name
    else
      result = "#{result}/#{self.name}"
    end

    result
  end


  protected
    def unique_name_amongst_siblings
      if persisted?
        if self.siblings.where.not(id: self.id).where(name: self.name).exists?
          errors.add :name, "must be unique. Folder with this name already exists at this path."
        end
      else
        if self.siblings.where(name: self.name).exists?
          errors.add :name, "must be unique at this path."
        end
      end
    end
end
