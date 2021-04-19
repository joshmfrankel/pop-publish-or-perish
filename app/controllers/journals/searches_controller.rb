module Journals
  class SearchesController < ApplicationController
    before_action :require_login

    def index
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            :journalsListing,
            partial: "journals/listing",
            locals: {
              journals: Journal.search_by_title(params[:search_term])
            }
          )
        }
      end
    end
  end
end
