module Api
  module V1
    class NotesController < Api::V1::ApplicationController
      before_action :set_note, only: %i[show update destroy]

      def index
        @notes = Note.all
        render json: @notes
      end

      def show
        render json: @note
      end

      def create
        @note = Note.new(note_params)

        if @note.save
          render json: @note, status: :created
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      def update
        if @note.update(note_params)
          render json: @note
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @note.destroy
          render json: { ok: true }
        else
          render json: { error: 'Unable to delete note' }, status: :unprocessable_entity
        end
      end

      private

      def set_note
        @note = Note.find(params[:id])
      end

      def note_params
        params.require(:note).permit(:title, :content)
      end
    end
  end
end
