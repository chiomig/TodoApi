class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include ActiveModel::SerializerSupport
  ActiveModel::Serializer.root = false
  ActiveModel::ArraySerializer.root = false
end
