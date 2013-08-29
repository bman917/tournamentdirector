
after "development:tournaments" do
	User.delete_all
	User.create(id: 1, email: 'bman917@yahoo.com', password: 'password', role: 'MASTER')
	User.create(id: 3, email: 'admin',             password: 'admin', role: 'ADMIN')
	User.create(id: 4, email: 'pepichan@yahoo.com',password: 'password', role: 'ADMIN')
	User.create(id: 5, email: 'user',password: 'user', role: 'USER')
	User.create(id: 7, email: 'encoder',password: 'encoder', role: 'ENCODER')

	@sletba_open = Tournament.find(1)

	@sletba_open.game_types << GameType.find('1')
	User.find(3).tournaments << @sletba_open
	User.find(4).tournaments << @sletba_open
	User.find(5).tournaments << @sletba_open
	User.find(7).tournaments << @sletba_open
end