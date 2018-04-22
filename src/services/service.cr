abstract class Service
  def self.call(*args, **kwargs)
    instance = self.new(*args, **kwargs)
    instance.call
    instance
  end

  abstract def call
end
