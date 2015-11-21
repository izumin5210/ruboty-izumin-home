module Ruboty
  module TrelloReporter
    module Actions
      class RememberBoard < Base
        def call
          remember
          report
        end

        private

        def report
          message.reply("Remembered #{given_name}'s id")
        end

        def remember
          board_ids[given_name] = given_id
        end

        def given_name
          message[:name]
        end

        def given_id
          message[:id]
        end
      end
    end
  end
end
