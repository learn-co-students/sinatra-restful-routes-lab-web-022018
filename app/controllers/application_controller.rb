require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::MethodOverride
  end
  get '/' do
    # erb :index
    redirect to '/recipes'
  end
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  delete '/recipes/:id/delete' do
# @post = Post.find_by_id(params[:id])/n  @post.delete /n redirect to '/posts'
    @recipe = Recipe.find(params[:id])
    recipe = @recipe
    recipe.delete
    # "#{@recipe.name} #{@recipe.id} was removed. params.id passed in was #{params[:id]}"
    redirect to '/recipes'
  end

  patch '/recipes/:id' do #edit action
  # post '/recipes/:id' do #edit action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end


  #*************************************************************
  get '/recipes/new' do
    erb :new
  end  #GET request to load the form to create a new blog post.
  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end
  #*************************************************************

  # Again in the application_controller.rb, create a controller action that uses RESTful routes
  # to display a single recipe.
  get '/recipes/:id/edit' do
      @recipe = Recipe.find_by_id(params[:id])
       erb :edit
  end


  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end



  # Create a third controller action that uses RESTful routes and renders a form to edit a single recipe.
  # This controller action should update the entry in the database with the changes, and
  # then redirect to the recipe show page
  #
  # Create a controller action (index action) that displays all the recipes in the database.
  #
end #class
# <%"        <li><%= {@r.name}%> <%= r.ingredients%> <%= r.cook_time%></li>"      %>
# <% if @recipes && @recipes.size > 0 %>
#   <% @recipes.each do |r| %>
#     <% r.size %><br>
#   <% end %>
# <% end %>
