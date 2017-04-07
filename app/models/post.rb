class Post < ApplicationRecord
  has_many :custom_fields, dependent: :destroy

  accepts_nested_attributes_for :custom_fields, allow_destroy: true
end
