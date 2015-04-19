class UsersController < ApplicationController
  def show
    @username = session[:username]
    @products = get_products
  end

  def new

  end

  def create
    client = HTTPClient.new
    rq = client.post(
      "#{REST_SERVER_URI}/user/create",
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

  private

  def get_products
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{session[:username]}:#{session[:password]}")
    rq = client.get(
      "#{REST_SERVER_URI}/product/list",
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    p rq

    if HTTP::Status.successful? rq.status
      content = JSON.parse(rq.content)
      return content.map {|x| x["name"]}
    else
      return []
    end
  end
end
