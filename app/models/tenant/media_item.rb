# == Schema Information
#
# Table name: tenant_media_items
#
#  id                         :bigint(8)        not null, primary key
#  folder_id                  :bigint(8)
#  tenant_id                  :bigint(8)
#  uploader_id                :bigint(8)
#  archived                   :boolean
#  online                     :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  predefined_metadata_fields :jsonb
#  customized_metadata_fields :jsonb
#

class Tenant::MediaItem < ApplicationRecord
  acts_as_tenant(:tenant, foreign_key: 'tenant_id', class_name: 'Admin::Tenant')

  belongs_to :folder, class_name: 'Tenant::Folder', optional: true
  belongs_to :uploader, class_name: 'Tenant::User'

  has_one_attached :file

  after_initialize do
    self.customized_metadata_fields = {} if self.customized_metadata_fields.nil?
  end

  before_create do
    if self.folder_id.present?
      add_file_size_to_folder(self.folder_id)
    end
  end

  before_destroy do
    if self.folder_id.present?
      remove_file_size_from_folder(self.folder_id)
    end
  end

  before_update do
    if self.folder_id_changed?

      if self.folder_id_was.present?
        remove_file_size_from_folder(self.folder_id_was)
      end

      if self.folder_id.present?
        add_file_size_to_folder(self.folder_id)
      end
    end
  end

  def creator
    uploader
  end

  def name
    file.filename.to_s
  end

  def remove_file_size_from_folder(folder_id)
    return if self.file.attachment.nil?
    
    # puts "REMOVING: #{folder_id.inspect}"
    previous_folder = nil

    previous_folder = Tenant::Folder.find(self.folder_id_was) if self.folder_id_was.present?
    subject_folder = Tenant::Folder.find(folder_id)

    subject_folder.update_columns(folder_size: subject_folder.folder_size - self.file.byte_size)

    updateable_ancestors = []
    if previous_folder.present? and previous_folder.ancestor_of?(subject_folder)
      # we're putting this item in an inner folder so we don't have to deduct the file size
    elsif previous_folder.present? and previous_folder.descendant_of?(subject_folder)
      # we're putting this item in an ancestor folder

      updateable_ancestors = previous_folder.ancestors.to_depth(subject_folder.ancestry_depth + 1)
    else
      # we're putting this item in a completely different root tree
      updateable_ancestors = subject_folder.ancestors
    end

    updateable_ancestors.each do |ancestor|
      ancestor.update_columns(folder_size: ancestor.folder_size - self.file.byte_size)
    end
  end

  def add_file_size_to_folder(folder_id)
    return if self.file.attachment.nil?

    previous_folder = nil

    previous_folder = Tenant::Folder.find(self.folder_id_was) if self.folder_id_was.present?
    subject_folder = Tenant::Folder.find(folder_id)

    subject_folder.update_columns(folder_size: subject_folder.folder_size + self.file.byte_size)

    updateable_ancestors = []
    if previous_folder.present? and previous_folder.ancestor_of?(subject_folder)
      # we're putting this item in an inner folder
      updateable_ancestors = subject_folder.ancestors.to_depth(previous_folder.ancestry_depth + 1)
    elsif previous_folder.present? and previous_folder.descendant_of?(subject_folder)
      # we're putting this item in an ancestor folder and we really don't have anything left to do
    else
      # we're putting this item in a completely different root tree
      updateable_ancestors = subject_folder.ancestors
    end

    updateable_ancestors.each do |ancestor|
      ancestor.update_columns(folder_size: ancestor.folder_size + self.file.byte_size)
    end
  end
end
