class Game < ApplicationRecord
	belongs_to :user
	has_many :users, through: :vacancies
	has_many :vacancies, dependent: :destroy
	has_many :comments, as: :pcomment
	
	def owner(id)
		self.update_columns(user_id: id)
	end
end
