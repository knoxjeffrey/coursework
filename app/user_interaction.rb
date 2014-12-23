class UserInteraction
  
  require_relative 'text_format'
  
  attr_reader :input
  
  def initialize(question)
    TextFormat.print_string(question)
    @input = TextFormat.chomp_it
  end
  
end