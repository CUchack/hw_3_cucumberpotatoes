class MoviesController < ApplicationController
  def show
    #    raise params[:order].inspect
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up  movie by unique ID
  # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:ratings] == nil and params[:ratings] != session[:ratings]
      @selected_ratings = session[:ratings]
      params[:ratings] = session[:ratings]
    else
      sort = params[:sort]
      @selected_ratings = params[:ratings] || {}
    end
    @all_ratings = Movie.all_ratings

    if params[:sort] != session[:sort] 
      session[:sort] = params[:sort]
    end
    if params[:ratings] != session[:ratings]
      session[:ratings] = params[:ratings]
    end

    if @selected_ratings == {}
      @selected_ratings = @all_ratings
    else
      @selected_ratings = params[:ratings]
    end
    if sort == 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    elsif sort == 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys,ordering)

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
