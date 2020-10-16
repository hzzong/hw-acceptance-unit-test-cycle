class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.same_director this_title
    director = Movie.find_by(title: this_title).director
    if director.nil? or director.blank?
      return nil
    else
      Movie.where(director: director).pluck(:title)
    end
  end
end
