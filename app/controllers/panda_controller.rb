class PandaController < ApplicationController
  def authorize_upload
    payload = JSON.parse(params['payload']) if params[:payload]

    options = {
      profiles: "h264,webm",
      # payload: 'something',
      # path_format: ':video_id/:profile/play',
    }
    if payload
    if payload['filename']
      url = '/videos/upload.json'
      options['file_name'] = payload['filename']
      options['file_size'] = payload['filesize']
    else
      url = "/videos.json"
      options['source_url'] = payload['fileurl']
    end
    end
    upload = Panda.post(url, options)

    render :json => {:upload_url => upload['location']}
  end
end