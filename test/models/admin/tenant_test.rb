# == Schema Information
#
# Table name: admin_tenants
#
#  id                         :bigint(8)        not null, primary key
#  company_name               :string
#  subdomain                  :string
#  domain                     :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  owner_id                   :bigint(8)
#  predefined_metadata_fields :string           is an Array
#  customized_metadata_fields :string           is an Array
#

require 'test_helper'

class Admin::TenantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
