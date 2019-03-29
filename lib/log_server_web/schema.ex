defmodule LogServerWeb.Schema do

  use Absinthe.Schema
  use Absinthe.Ecto, repo: LogServer.Repo

  alias LogServer.Logs.Log
  alias LogServer.Logs.Event
  alias LogServer.Accounts.User



    import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  import_types Absinthe.Type.Custom

  alias LogServerWeb.Resolvers.LogResolver
  alias LogServerWeb.Resolvers.UserResolver
  alias LogServerWeb.Resolvers.EventResolver


  def context(ctx) do
    loader =
      Dataloader.new
      |> Dataloader.add_source(Log, Log.data())
      |> Dataloader.add_source(Event, Event.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end


  object :user do
    field :id, non_null(:integer)
    field :email, :string
    field :username, :string
    field :password_hash
    field :password, :string
    field :admin, :boolean
    field :verified, :boolean
    field :inserted_at, :naive_datetime
    field :logs, list_of(:log), resolve: dataloader(Log)
  end

  object :log do
    field :id, non_null(:integer)
    field :name, :string
    field :user_id, :integer
    field :type, :string
    field :inserted_at, :naive_datetime
    # field :events, list_of(:event), resolve: dataloader(Event)
  end


  object :event do
    field :id, :integer
    field :log_id, :integer
    field :quantity, :float
  end



  query do

    field :get_user, non_null(list_of(non_null(:user))) do
      arg :id, non_null(:integer)
      resolve &UserResolver.get_user/3
    end

    field :list_users, non_null(list_of(non_null(:user))) do
      resolve &UserResolver.list_users/3
    end

    field :logs_for_user, non_null(list_of(non_null(:log))) do
      arg :user_id, non_null(:integer)
      resolve &LogResolver.logs_for_user/3
    end

    field :list_logs, non_null(list_of(non_null(:log))) do
      resolve &LogResolver.list_logs/3
    end

    field :list_events, non_null(list_of(non_null(:event))) do
      resolve &EventResolver.list_events/3
    end

  end



  mutation do

    field :create_log, :log do
      arg :name, non_null(:string)
      arg :user_id, non_null(:integer)
      arg :type, non_null(:string)

      resolve &LogResolver.create_log/3
    end

    field :create_event, :event do
      arg :log_id, non_null(:integer)
      arg :quantity, non_null(:float)

      resolve &EventResolver.create_event/3
    end

  end


  @docp """
  http://localhost:4000/graphiql


  {
    getUser(id: 1) {
      username
      email
      logs {name}
    }
  }

  mutation {
    createLog(userId: 1, name: "Piano", type: "Cumulative") {
       name
    }
  }


  {
    listLogs {
      name
      id
      userId
      type
    }
  }

  {
  logsForUser(userId: 1) {
    name
    id
    userId
    type
  }
  }


  mutation {
    createEvent(logId: 1, quantity: 24) {
       quantity
       insertedAt
    }
  }


  {
    listEvents {
      id
      logId
      quantity
    }
  }



  """

end

