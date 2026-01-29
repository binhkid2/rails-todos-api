class Task < ApplicationRecord
  self.primary_key = "id"

  before_create do
    self.id ||= SecureRandom.uuid
  end
end
