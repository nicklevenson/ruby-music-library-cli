require 'pry'

class Song
    extend Concerns::Findable
    attr_accessor :name, :artist, :genre
    @@all = []
    def initialize(name, artist=nil, genre=nil)
        @name = name
        if artist != nil
            self.artist=(artist)
        end
        if genre != nil
            self.genre=(genre)
        end
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def self.destroy_all
        @@all = []
    end

    def self.create(name)
        name = self.new(name).save
        self.all[-1]
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    # def self.find_by_name(name)
    #    @@all.select{|song|song.name==name}[0]
      
    # end

    # def self.find_or_create_by_name(name)
    #     if find_by_name(name)
    #         find_by_name(name)
    #     else
    #         create(name)
    #     end
    # end

    def self.new_from_filename(filename)
        fileArray = filename.split(" - ")
        songName = fileArray[1]
        artistName = fileArray[0]
        genreName = fileArray[2].split(".mp3").join
        song = find_or_create_by_name(songName)
        song.artist = Artist.find_or_create_by_name(artistName)
        song.genre = Genre.find_or_create_by_name(genreName)
        song
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end

end
