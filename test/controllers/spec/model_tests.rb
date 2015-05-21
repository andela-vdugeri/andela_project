require 'spec_helper'


describe User do
	def '#initialize' do
		it 'creates a new user' do
			user = User.new
			user.username = 'danvery'
			user.password = 'dan'
			expect(user.username).to eq 'danvery'
			expect(user.username).to eq 'dan'
		end
	end
end