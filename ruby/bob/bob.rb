class Phrase < String
  def initialize(str)
    super(str.to_s.strip)
  end

  def question?
    end_with?('?')
  end

  def yelling?
    %r{[A-Z]} =~ self && upcase == self
  end

  def silence?
    %r{^$} =~ self
  end

  private

  attr_reader :remark
end

class ResponseFactory
  def respond_to(phrase)
    if phrase.silence?
      'Fine. Be that way!'
    elsif phrase.yelling?
      'Whoa, chill out!'
    elsif phrase.question?
      'Sure.'
    else
      'Whatever.'
    end
  end
end

class Bob
  def self.hey(words)
    new.hey(words)
  end

  def initialize(response_factory: ResponseFactory.new)
    @response_factory = response_factory
  end

  def hey(words)
    response_factory.respond_to(Phrase.new(words))
  end

  private

  attr_reader :response_factory
end
