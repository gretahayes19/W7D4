class Goal < ApplicationRecord
    validates :name, :details, presence: true
    belongs_to :user
end
