class MoviesController < ApplicationController
  def show
    #    raise params[:order].inspect
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up  movie by unique ID
  # will render app/views/movies/show.<extension> by default
  end

  def index
#    session.clear
    puts "ruby session before comparison ="
    puts session
    puts "ruby params before comparison = "
    puts params

    if params[:sort] == nil and params[:sort] != session[:sort] #and params[:session_id] == session[:session_id]
      sort = session[:sort]
      params[:sort] = session[:sort]
    end
    if params[:ratings] == nil and params[:ratings] != session[:ratings] #and params[:session_id] == session[:session_id]
      @selected_ratings = session[:ratings]
      params[:ratings] = session[:ratings]
#    elsif params[:session_id] != session[:session_id]
#      session.delete[:ratings]
#      session.delete[:sort]      
    else
#      params[:session_id] = session[:session_id]
      sort = params[:sort]# || session[:sort]
      @selected_ratings = params[:ratings] || {}
    end
    @all_ratings = Movie.all_ratings
    puts "ruby session before setting params = session = "
    puts session
    puts "ruby params before setting params = session = "
    puts params
    puts "sort before setting params = session = "
    puts sort

    if params[:sort] != session[:sort] #and params == nil
      session[:sort] = params[:sort]
    end
    if params[:ratings] != session[:ratings]
      session[:ratings] = params[:ratings]
    end
    puts "ruby session = "
    puts session
    puts "ruby params = "
    puts params
    puts "sort = "
    puts sort
    puts "assigned the ratings to be ================"
    puts @selected_ratings

    if @selected_ratings == {}
      @selected_ratings = @all_ratings
    #      @selected_ratings = Hash.new(0)
    #      @all_ratings.each do |rating|
    #        @selected_ratings[rating] = 1
    #      end
    else
      @selected_ratings = params[:ratings]
      puts "assigned the ratings to be ================"
      puts @selected_ratings
    #      session[:ratings] = params[:ratings]
    #      @selected_ratings = @selected_ratings.keys
    end
    if sort == 'title'
      #      @movies = Movie.order_by(sort)#movie.sort_by {|m| m.title}
      ordering,@title_header = {:order => :title}, 'hilite'
    #      redirect_to :sort => sort, :ratings => @selected_ratings and return
    #      @movies = Movie.find_by_rating!("G")
    #@movies = Movie.order_by(session[:sort])
    #ordering,@title_header = {:order => :title}, 'hilite'
    #     @movies = Movie.find_all_by_rating(@selected_ratings.keys,ordering)
    elsif sort == 'release_date'
      #      @movies = Movie.order_by(sort)#movie.sort_by {|m| m.release_date}
      ordering,@date_header = {:order => :release_date}, 'hilite'
    #     redirect_to :sort => sort, :ratings => @selected_ratings and return
    #   @movies = Movie.find_all_by_rating(@selected_ratings.keys,ordering)
    #    else
    #     session.clear
    #      @movies = Movie.find_all_by_rating(@selected_ratings.keys,ordering)
    #     @movies = Movie.all
    end
    puts "@selected_ratings = "
    puts @selected_ratings
    @movies = Movie.find_all_by_rating(@selected_ratings.keys,ordering)

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
