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

require 'test_helper'

class Tenant::MediaItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
