class MusicLibraryController
    attr_accessor :library, :musicImporter
    def initialize(library = "./db/mp3s")
        @library = library
        @musicImporter = MusicImporter.new(@library).import
    end

    def call 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        
        input = gets.chomp
        if input == "list songs"
            list_songs
        end
        if input == "list artists"
            list_artists
        end
        if input == "list genres"
            list_genres
        end
        if input == "list artist"
            list_songs_by_artist
        end
        if input == "list genre"
            list_songs_by_genre
        end
        if input == "play song"
            play_song
        end

        if input != "exit"
            call
        end 
    end

    def list_songs
       songs = []
       final = []
       Song.all.each{|song| songs << song.name }
       songs.sort.uniq.each_with_index{|song, index| puts  "#{index+1}. #{Song.find_by_name(song).artist.name} - #{song} - #{Song.find_by_name(song).genre.name}"} 
    end

    def list_artists
        Artist.all.collect{|artist| artist.name}.sort.each_with_index do |artist, index|
            puts "#{index+1}. #{artist}"
        end  
    end

    def list_genres
        Genre.all.collect{|genre| genre.name}.sort.each_with_index do |genre, index|
            puts "#{index+1}. #{genre}"
        end  
    end

    def list_songs_by_artist

        puts "Please enter the name of an artist:"
        input = gets.chomp
        if input != nil
            if Artist.find_by_name(input) != nil
                artist = (Artist.find_by_name(input))
                songs = artist.songs
                songs.collect{|song|song.name}.sort.each_with_index{|song, index| puts "#{index+1}. #{song} - #{Song.find_by_name(song).genre.name}"}
            end
        end
        
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        if input != nil
            if Genre.find_by_name(input) != nil
                genre = (Genre.find_by_name(input))
                songs = genre.songs
                songs.collect{|song|song.name}.sort.each_with_index{|song, index| puts "#{index+1}. #{Song.find_by_name(song).artist.name} - #{song}"}
            end
        end
        
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
        if input != nil && input > 0 && input < Song.all.count + 1
            songs = []
            final = []
            Song.all.each{|song| songs << song.name }
            song = songs.sort.uniq[input-1]
            if Song.find_by_name(song) != nil
                artist = Song.find_by_name(song).artist.name
                puts "Playing #{song} by #{artist}"
            end
        end
    end

end
