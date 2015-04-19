class SessionsController < ApplicationController
  def new
  end

  def create
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{params[:session][:username]}:#{params[:session][:password]}")
    rq = client.get(
      "#{REST_SERVER_URI}/user/find/#{params[:session][:username]}",
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    if HTTP::Status.successful? rq.status
      content = JSON.parse(rq.content)
      log_in content["id"], content["username"], params[:session][:password]
      redirect_to show_path
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
