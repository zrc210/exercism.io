module HelloWorld
  class << self
    def hello(name = 'World')
      "Hello, #{name}!"
    end
  end
end
