module Ruboty
  module Handlers
    class TrelloReporter < Base

      env :TRELLO_CONSUMER_KEY, "Pass trello consumer token"
      env :TRELLO_CONSUMER_SECRET, "Pass trello consumer token"
      env :TRELLO_OAUTH_TOKEN, "Pass trello oauth token"

      on(
        /remember board id "(?<name>.+)" "(?<id>.+)"/,
        name: "remember_board",
        description: "Remenber board id"
      )

      on(
        /get cards from "(?<list>.+)" in "(?<board>.+)"/,
        name: "get_cards",
        description: "Get cards from board/list"
      )

      def remember_board(message)
        Ruboty::TrelloReporter::Actions::RememberBoard.new(message).call
      end

      def get_cards(message)
        Ruboty::TrelloReporter::Actions::GetCards.new(message).call
      end
    end
  end
end
