class Genre
    extend Concerns::Findable
    attr_accessor :name, :songs
    @@all = []
    def initialize(name)
        @name = name
        @songs = []
    end

    def add_song(song)
        if song.genre == nil
            song.genre = self
            @songs << song
        end
        if !(@songs.include?(song))
        @songs << song
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
    
    def artists
        @songs.collect {|song| song.artist}.uniq
    end


end
