# UI describes an Object to interact with the User through the Terminal
class UI
  
  # Convenience method, creates a single "UI" object (a singleton object) for us
  # to use throughout the life-cycle of the app.
  def self.shared_instance
    @shared_instance ||= new
  end
  
  # When calling a method on UI, if the class doesn't respond to it, try it as an
  # instance method on our singleton
  def self.method_missing(method_name, *args, &block)
    shared_instance.send(method_name, *args, &block)
  end
  
  # Say something to the User
  def tell(message)
    with_spaces = message.center(message.length + 2)
    puts with_spaces.center(100, "***")
  end
  
  # Take input from the User
  def listen
    gets.chomp
  end
  
  # Say something to the User and listen for a response
  def ask(question)
    tell(question)
    listen
  end
  
  # Ask the User a yes/no question
  def ask_yes_no(question)
    value = ''
    value = ask(question) until %w[ y n ].include?(value)
    return value
  end
  
  # Clear the screen
  def clear
    puts `clear`
  end
  
end