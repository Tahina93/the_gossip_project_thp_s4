require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
	erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
   erb :new_gossip
  end

  post '/gossips/new/' do 
  	Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  #permet d'ouvrir la page show.erg de chaque potins
  get '/gossips/:id/' do
   erb :show
  end

  #permet d'ouvrir le lien vers edit.erb
  get '/gossips/:id/edit/' do
   erb :edit
  end

post '/gossips/:id/edit/' do 
  	Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

end