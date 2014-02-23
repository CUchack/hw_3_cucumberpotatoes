class MoviesController < ApplicationController

  def show
#    raise params[:order].inspect
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up  movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort]# || session[:sort]
    movie = Movie.all
#    puts "sort ="
#    puts sort
#    puts "params[:sort] = "
#    puts params[:sort]
#    puts "session[:sort]"
#    puts session[:sort]
    if sort == 'title'
      @movies = movie.sort_by {|m| m.title}
      @title_header = 'hilite'
    elsif sort == 'release_date'
      @movies = movie.sort_by {|m| m.release_date}
      @date_header = 'hilite'
    else
      @movies = Movie.all
    end
       
#    if session[:order] == params[:order]
#      session[:order] = 'desc'
#    else 
#      session[:order] = params[:order] || session[:order]      
#    end
#    if session[:release] == params[:release]
#      session[:release] = 'desc'
#    else
#     session[:release] = params[:release] || session[:release]
#    end 
     #raise 'wtf'
#    puts session.inspect
#    puts "session order = "
#    puts session[:order]
#    @movies = Movie.all
#    @movies = Movie.order_by(session[:sort])
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
