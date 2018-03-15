class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  patch '/recipes/:id' do
    edited_recipe = Recipe.find(params[:id])
    edited_recipe.name = params[:name]
    edited_recipe.ingredients = params[:ingredients]
    edited_recipe.cook_time = params[:cook_time]
    edited_recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end


  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect '/recipes/' + "#{@recipe.id}"
  end

  post '/recipes/:id/delete' do
      Recipe.destroy(params[:id])
      erb :delete
  end


end
