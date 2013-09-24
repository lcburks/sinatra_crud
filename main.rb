# HEROKU Version

require 'sinatra' 
require 'active_record'
require 'pg'

# ActiveRecord::Base.establish_connection(
#   :adapter => "postgresql",
#   :host => "localhost",
#   :username => "laneburks", 
#   :password => "",
#   :database => "backs_and_tests"
# )

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/backs_and_tests')

#this is because my computer is somehow using thin server instead of webbrick
after do 
  ActiveRecord::Base.connection.close
end


ActiveRecord::Base.logger = Logger.new(STDOUT)



class Back < ActiveRecord::Base
	has_many :tests
end 

class Test < ActiveRecord::Base
	belongs_to :back
end



# Sinatra
before do
	@nav_backs = Back.all #returns all objects in the backs table  (it knows becuase you call the method on the class Back) in an array by creating a SQL stmt that queires the db, and called the array @nav_backs. 
end


# Routes
get '/' do # sends you to a simple welcome screen
	erb :home
end


get '/backs' do
	erb :backs #index, basically. list each back and each of his test results
end




get '/backs/new' do # ?????? get..new and post...create go together. get..new is the form create a new back on a form and post takes the info you ptu om the form into a dog hash/array(?)puts it into the params hash (does it put it into params hash here or in the new,erb page) and uses the keys and values from the back(singular) hash to pass into the new dog object with all those params given in the form???
	erb :new
end

post '/backs/create' do # OK so without this one, the backs/new form never saves to the db. this saves it to the db (in the backs table). you cant type it in the url to get to it, it jsut says sinatra doesnt knwo this diutty so maye that what post does. it is untypable in the irl.  At the top of the new form backs/create page isreferenced liek this: <form action='<%= @back.nil? ? "/backs/create" : "/backs/#{@back.id}" %>' method='post'>. See excalt ywhat thos line does. But this is how the new page passes info on to the create page and links the two...BEFORE I figured that otu i typed this in:   this doesnt render anythgin so it doesnt go to any other page. it saves them(anactive recor command d)in the TABLE of the purlazed name, whcih is dogs,so the backs table. then it redirects us back to tthe backs page to see th eupdated info 
	back = Back.new(params[:back]) # params is a hash that passes the thoigjns form get and post?? 
	back.save #Active Record method that saves the new object in the backs table in the db?
	redirect '/backs' # i had just the root at first
end




get '/backs/:back_id' do # back_id comes up in main, the Schema-table creation(as an Attribute of tests and the FOREIGN KEY in the relationship) and in new_test
  @back = Back.find(params[:back_id]) #the activerecord .find method has 4 possibel serach options, by id, first, last, or all. it will return the record (s) yorue searching for in the backs table. 
  erb :back
end 



get '/backs/:back_id/edit/' do #this is done on new page, there is no edit page
  @back = Back.find(params[:back_id])
  erb :new
end 

post '/backs/:back_id' do #this actual editing is done on the 'new' page, there is no edit page
  back = Back.find(params[:back_id]) # find the specific back by id
  back.update_attributes(params[:back])
  redirect '/backs'
end




post '/backs/:back_id/delete' do
  back = Back.find(params[:back_id])
  back.destroy
  redirect '/backs'
end




get '/backs/:back_id/new_test' do
	@back_id = params[:back_id]
	erb :new_test
end





post '/backs/:back_id/delete' do
  back = Back.find(params[:back_id])
  back.destroy
  redirect '/backs'
end




get '/backs/:back_id/new_test' do
  @back_id = params[:back_id]
  erb :new_test
end


post '/backs/:back_id/create_test' do
  back = Back.find(params[:back_id])
  test = back.tests.new(params[:test])
  # test.forty_dash = params[:test][:forty_dash]
  # test.bench_press = params[:test][:bench_press]
 #  test.vertical_jump = params[:test][:vertical_jump]
 #  test.broad_jump = params[:test][:broad_jump]
 #  test.grade = params[:test][:grade]
  test.save

  # back.tests << Test.new(params[:test])

  redirect '/backs'
end


# post '/backs/:back_id/create_test' do
# 	back = Back.find(params[:back_id])
#   test = back.tests.new
# 	test.forty_dash = params[:test][:forty_dash]
#   # test.save
# 	# test.bench_press = params[:test][:bench_press]
#  #  test.save
#  #  test.vertical_jump = params[:test][:vertical_jump]
#  #  test.save
#  #  test.broad_jump = params[:test][:broad_jump]
#  #  test.save
#   test.grade = params[:test][:grade]
#   test.save

# 	# back.tests << Test.new(params[:test])

# 	redirect'/backs'
# end



