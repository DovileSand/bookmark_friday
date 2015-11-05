require 'sinatra/base'
require_relative 'data_mapper_setup'

ENV['RACK_ENV'] ||= 'development'

class DataRecorder < Sinatra::Base

  get '/'do
    redirect :links
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(title: params[:title],
                      url: params[:url])
    tag = Tag.new(name:params[:tag])
    link.tags << tag
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
