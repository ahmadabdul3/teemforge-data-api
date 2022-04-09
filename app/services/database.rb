class Database
    @@storage = {}
    @@state = 'idle'

    def self.storage
      # Return the value of this variable
      @@storage
    end
end
