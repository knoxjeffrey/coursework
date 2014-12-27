class UI
  
  def self.shared_instance
    @shared_instance ||= new
  end
  
  def self.method_missing(method_name, *args, &block)
    shared_instance.send(method_name, *args, &block)
  end
  
  def tell(message)
    with_spaces = message.center(message.length + 2)
    puts with_spaces.center(100, "***")
  end
  
  def listen
    gets.chomp
  end
  
  def ask(question)
    tell(question)
    listen
  end
  
  def clear
    puts `clear`
  end
  
  def ask_yes_no(question)
    value = ''
    value = ask(question) until %w[ y n ].include?(value)
    return value
  end
  
end