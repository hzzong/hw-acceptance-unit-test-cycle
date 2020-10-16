require 'rails_helper'

    RSpec.describe MoviesController, :type => :controller do
        before(:each) do
                @movie_1 = Movie.create(title: "Movie",rating: "G", description:"description", director: "director1",release_date: "10152020")
                @movie2 = Movie.create(title: "Movie2",rating: "G", description:"description", director: "director1",release_date: "10152020")
                @movie3 = Movie.create(title: "Movie3",rating: "R", description:"description", director: "director3",release_date: "10152020")
                @movie_4 = Movie.create(title: "Movie has no director",rating: "PG", description:"description", director: nil, release_date: "10152020")
        end
        
        
        describe 'new movie' do
            
            it 'initialized correctly' do
                get :new,  id: @movie_1[:id]
                expect(Movie.find(@movie_1.id)[:title]).to eql("Movie")
                expect(expect(response).to render_template(:new))
            end
        
            it 'should show the page' do 
                get :show, id: @movie_1[:id]
                expect(response).to render_template(:show)
            end
            
            it 'should be sorted by title' do
                get :index, {sort: 'title'}
                expect(assigns(:title_header)).to eql('bg-warning hilite')
            end
            
            it 'should be sorted by release date' do
                get :index, {sort: 'release_date'}
                expect(assigns(:date_header)).to eql('bg-warning hilite')
            end
            
            it 'should be able to create a new movie' do 
                expect {post :create, movie: {:title => 'new movie', :director => 'directorN', :release_date => '10152020'}}.to change { Movie.count }.by(1)
            end
            
        describe 'find similar movie' do 
            it 'should gets movies with the same director' do 
                get :similar, id: @movie_1[:id]
                @n1 = Movie.where(:director => @movie_1.director).size + 2
                expect(@n1 - Movie.where(:director => @movie_1.director).size).to eq(2)
            end 
            
            it 'should go to the sad path' do 
                get :similar, id: @movie_4[:id]
                expect(response).to redirect_to(movies_path)
            end
        end 


        end
    end
    