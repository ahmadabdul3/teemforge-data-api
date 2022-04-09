class TFLogger
    def self.log(title: '', message: '')
        puts '##### ----- #####'
        puts title unless title.nil? || title.empty?
        puts message
        puts '##### ----- #####'
    end
end
