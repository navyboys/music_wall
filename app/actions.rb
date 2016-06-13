get '/' do
  haml :index
end

get '/musics' do
  @musics = Music.all
  haml :'musics/index'
end

get '/musics/new' do
  @music = Music.new
  haml :'musics/new'
end

post '/musics' do
  @music = Music.new(
    author: params[:author],
    title: params[:title],
    url: params[:url]
  )
  if @music.save
    redirect '/musics'
  else
    haml :'musics/new'
  end
end
