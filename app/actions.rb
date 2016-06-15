helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end

before do
end

get '/' do
  haml :index
end

get '/signup' do
  @user = User.new
  haml :'users/new'
end

post '/signup' do
  @user = User.new(params)
  @user.password = params[:password]

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
    flash[:notice] = "You're successfully logged in."
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
  @musics = Music.all.order(vote_count: :desc)
  haml :'musics/index'
end

get '/musics/:id' do
  @music = Music.find_by(id: params[:id])
  haml :'musics/show'
end

post '/musics/:id/reviews' do
  music = Music.find_by(id: params[:id])
  @review = Review.new(
    user: current_user,
    music: music,
    rating: params[:rating],
    content: params[:content]
  )
  @review.save
  redirect "/musics/#{params[:id]}"
end

delete '/musics/:music_id/reviews/:review_id' do
  review = Review.find_by(id: params[:review_id])
  review.destroy
  redirect "/musics/#{params[:music_id]}"
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
