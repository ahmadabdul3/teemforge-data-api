class Database
    @storage = {}
    @state = 'idle'

    class << self
        attr_reader :storage
        attr_accessor :state
    end
end
