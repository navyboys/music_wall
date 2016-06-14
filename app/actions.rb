get '/' do
  haml :index
end

get '/signup' do
  @user = User.new
  haml :'users/new'
end

post '/signup' do
  @user = User.new(params)

  if @user.save
    session[:user_id] = @user.id
    redirect '/login'
  else
    haml :'users/new'
  end
end

get '/login' do
  @user = User.new
  haml :'sessions/new'
end

post '/login' do
  user = User.where(email: params[:email]).first
  if  user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/musics'
  else
    flash[:error] = "There is something wrong with your username or password."
    redirect '/login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect 'musics'
end

get '/musics' do
  @musics = Music.all
  @musics = @musics.where(user_id: session[:user_id]) if session[:user_id]
  haml :'musics/index'
end

get '/musics/new' do
  @music = Music.new
  haml :'musics/new'
end

post '/musics' do
  @music = Music.new(
    user_id: session[:user_id],
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

get '/musics/:id/vote' do
  @vote = Vote.new(
    user_id: session[:user_id],
    music_id: params[:id],
    vote: true
  )
  @vote.save
  redirect '/musics'
end
