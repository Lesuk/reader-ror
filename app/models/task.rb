class Task < ActiveRecord::Base
	belongs_to :user

	scope :in_process, -> { where(completed: false) }
	scope :done, -> { where(completed: true) }

	validates :title, presence: true
end
