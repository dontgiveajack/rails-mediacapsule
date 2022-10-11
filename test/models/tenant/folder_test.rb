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

require 'test_helper'

class Tenant::FolderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
