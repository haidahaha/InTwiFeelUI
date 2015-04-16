class UsersController < ApplicationController
  def show
    @username = params[:username]
  end

  def new

  end

  def create
    client = HTTPClient.new
    rq = client.post(
      "http://127.0.0.1:8080/user/create",
      {
        username: params[:user][:username],
        password: params[:user][:password]
      }.to_json,
      {"Content-Type" => "application/json"}
    )

    p rq

    if HTTP::Status.successful? rq.status
      content = JSON.parse(rq.content)
      redirect_to login_path, notice: "User #{content["username"]} has been successfully created. Let sign in now."
    else
      render 'new'
    end
  end
end
