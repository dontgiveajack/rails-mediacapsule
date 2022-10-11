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

class Admin::Tenant < ApplicationRecord
  SPECIAL_SUBDOMAINS = %w(www admin public mail ftp smtp imap webmail cpanel webmin http https media mediacapsule media-capsule staging prod)

  belongs_to :owner, class_name: 'Tenant::User', inverse_of: :company
  # validates_presence_of :owner

  validates :company_name, :subdomain, :domain, presence: true
  validates :domain, uniqueness: true

  validates :subdomain, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/, message: 'must contain only lowercase letters, digits and dashes' }, exclusion: { in: SPECIAL_SUBDOMAINS }, length: { in: 3..20 }

  attr_accessor :host

  before_validation do
    if self.domain.blank? and self.host.present?
      result = self.host.split('.')
      result[0] = self.subdomain
      self.domain = result.join('.')
    end
  end
end
