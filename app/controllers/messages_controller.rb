class MessagesController < ApplicationController
  before_action :set_match, only: :create

  def create
    @message = Message.new(message_params)
    @message.match = @match
    @message.user = current_user
    authorize @message
    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
                                                              locals: { message: @message, user: current_user })
        end
        format.html { redirect_to matchs_path(@match) }
      end
    else
      render "matchs/show", status: :unprocessable_entity
    end
  end

  private

  def set_match
    @match = Match.find(params[:match_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
