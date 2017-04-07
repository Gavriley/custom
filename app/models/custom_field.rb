class CustomField < ApplicationRecord
  belongs_to :post, { optional: true }
  belongs_to :parent, class_name: 'CustomField', foreign_key: :parent_id, optional: true

  has_many :children, class_name: 'CustomField', foreign_key: :parent_id

  enum kind: [:custom, :desc, :link, :role]

  default_scope -> { order order: :asc }

  acts_as_list column: :order, scope: :post

  # validates_uniqueness_of :post, scope: :kind, if: 'desc? || link?'

  # validates_presence_of :value, if: 'desc? || link?'

  accepts_nested_attributes_for :children, allow_destroy: true
end
