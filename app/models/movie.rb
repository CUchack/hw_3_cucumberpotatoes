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
    {"G"=>1, "PG"=>1, "PG-13"=>1, "NC-17"=>1, "R"=>1}
  end  
end
