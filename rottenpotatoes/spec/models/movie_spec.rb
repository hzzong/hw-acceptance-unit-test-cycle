require 'rails_helper'

RSpec.describe Movie, :type => :model do 
   before(:all) do 
       @movie1 = Movie.create(title: "Movie1",rating: "G", description:"description", director: "director1",release_date: "10152020")
       @movie2 = Movie.create(title: "Movie2",rating: "G", description:"description", director: "director1",release_date: "10152020")
       @movie3 = Movie.create(title: "Movie3",rating: "R", description:"description", director: "director3",release_date: "10152020")
       @movie4 = Movie.create(title: "Movie has no director",rating: "PG", description:"description", director: nil, release_date: "10152020")
    end
    
    describe 'all ratings' do
      it 'are exist' do
         expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
       end
    end 
    describe 'find movies with same director' do 
        
      context 'has director' do 
          it 'get similar movies' do
              expect(Movie.same_director(@movie1.title).uniq).to eql(["Movie1", "Movie2"])
              expect(Movie.same_director(@movie1.title).uniq).to_not include(["Miao"])
            
          end
          it 'has one movie' do
            expect(Movie.same_director(@movie3.title).uniq).to eql(["Movie3"])
          end
      end
    
      context 'has no director' do 
        it 'gets nil' do
          expect(Movie.same_director(@movie4.title)).to eql(nil)
        end
      end
    end
end