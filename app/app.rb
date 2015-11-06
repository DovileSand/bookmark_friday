require 'sinatra/base'
require_relative 'data_mapper_setup'

ENV['RACK_ENV'] ||= 'development'

class DataRecorder < Sinatra::Base

  get '/' do
    erb :'links/signup'
  end

  post '/signup' do
    User.create(username: params[:username], email: params[:email], password: params[:password])
    redirect("/confirm/#{params[:username]}")
  end

  get '/confirm/:username' do
    @username = params[:username]
    erb :'links/confirm'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    params[:tag].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect :links
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
