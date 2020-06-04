class NewDataPrompt < TTY::Prompt
    attr_reader :response

    def initialize(args)
        super
        @prompt = args[:prompt]
        @old_value = args[:old]
        ask_user
    end

    def ask_user
        @response = ask(@old_value + " didn't seem to work.\nWhat value would you like to try instead? (cancel to skip)")
    end

end