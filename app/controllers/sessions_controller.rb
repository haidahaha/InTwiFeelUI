class SessionsController < ApplicationController
  def new
  end

  def create
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{params[:session][:username]}:#{params[:session][:password]}")
    rq = client.get(
      "http://127.0.0.1:8080/user/find/#{params[:session][:username]}",
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    if HTTP::Status.successful? rq.status
      content = JSON.parse(rq.content)
      log_in content["id"]
      redirect_to show_path(username: content["username"])
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
