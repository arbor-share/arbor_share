class UserBlock < ApplicationRecord
  belongs_to :blocking_user, foreign_key: 'blocking_user_id', class_name: :User
  belongs_to :blocked_user, foreign_key: 'blocked_user_id', class_name: :User
end
