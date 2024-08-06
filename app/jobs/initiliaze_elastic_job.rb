# called in config/enviroment,rb
class InitiliazeElasticJob < ApplicationJob
  queue_as :default

  def perform()
    Message.__elasticsearch__.create_index!
    Chat.__elasticsearch__.create_index!
    ChatApp.__elasticsearch__.create_index!
  end
end
