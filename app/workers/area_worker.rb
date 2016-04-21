class AreaWorker
  include Sidekiq::Worker

  def perform(id)
    # Do something
    Area.find(id).process
  end
end
