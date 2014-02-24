class Movie < ActiveRecord::Base
  @@order = false
  def self.order_by order
    if order == 'title'
      #get movies in desecding order
      Movie.order("title asc")
    else
      Movie.order("release_date asc")
    #get movies in ascending order
    end
  end
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end  
end
