

class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs
    @@all = []
    def initialize(name)
        @name = name
        @songs = []
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        end
        if @songs.include?(song) 
            nil
        else 
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
    
    def genres
        @songs.collect {|song| song.genre}.uniq
    
    end
    


end

