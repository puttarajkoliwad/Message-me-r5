class MessagesController < ApplicationController

    before_action :require_user

    def create
        new_message = current_user.messages.build(message_params)
        if new_message.save
            ActionCable.server.broadcast "chatroom_channel",
                                        rendered_message: render_message(new_message)
        end
    end

    

    private

    def message_params
        params.require(:message).permit(:body)
    end

    def render_message(new_message)
        render(partial: "message", locals: {message: new_message})
        #render(partial: "<partial_name>", locals: { <variable_name_used_in_the_partial>: <argument_to_be_rendered> })
    end

end
#hbkjfvanv 