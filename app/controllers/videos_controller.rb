class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings["h264"]
  end

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    video_params
    #@video = Video.new
    puts ENV['PANDASTREAM_URL']
    puts params[:video][:panda_video_id].tempfile.path
    @video = Video.create!(params[:video])
    videop = Panda::Video.new(:file => params[:video][:panda_video_id].tempfile.path)
    videop.create

    redirect_to root_path
  end

  def show
  end


  private
  def video_params
    params.require(:video).permit!
  end
end