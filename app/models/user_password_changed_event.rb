class UserPasswordChangedEvent < ApplicationRecord
    belongs_to :es_test
  
    validates :es_test_id, presence: true
    validates :new_password_digest, presence: true
    validates :changed_at, presence: true
end
