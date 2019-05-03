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



   enum :log_type_value do
    value :FLOAT
    value :INTEGER
    value :DATETIME
   end


  object :user do
    field :id, non_null(:integer)
    field :email, non_null(:string)
    field :username, non_null(:string)
    field :password_hash, non_null(:string)
    field :password, non_null(:string)
    field :admin, non_null(:boolean)
    field :verified, non_null(:boolean)
    field :inserted_at, non_null(:naive_datetime)
    field :logs, non_null(list_of(non_null(:log))), resolve: dataloader(Log)
  end

  object :log do
    field :id, non_null(:integer)
    field :name, non_null(:string)
    field :user_id, non_null(:integer)
    field :log_type, non_null(:string) do
      arg :my_arg, :log_type_value, default_value: :FLOAT
    end
    field :inserted_at, non_null(:naive_datetime)
    field :events, non_null(list_of(non_null(:event))), resolve: dataloader(Event)
  end


  object :event do
    field :id, non_null(:integer)
    field :log_id, non_null(:integer)
    field :unit, non_null(:string)
    field :value, non_null(:float)
    field :inserted_at, non_null(:naive_datetime)
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

    field :list_events_for_log, non_null(list_of(non_null(:event))) do
      arg :log_id, non_null(:integer)
      resolve &EventResolver.list_events_for_log/3
    end

    field :list_events, non_null(list_of(non_null(:event))) do
      resolve &EventResolver.list_events/3
    end

    field :delete_event, non_null(list_of(non_null(:event))) do
      resolve &EventResolver.delete_event/3
    end

  end



  mutation do

    field :create_log, :log do
      arg :name, non_null(:string)
      arg :user_id, non_null(:integer)
      arg :log_type, non_null(:log_type_value)

      resolve &LogResolver.create_log/3
    end

    field :create_event, :event do
      arg :log_id, non_null(:integer)
      arg :value, non_null(:float)

      resolve &EventResolver.create_event/3
    end

  end


  @docp """
  http://localhost:4000/graphiql


  query {
    getUser(id: 1) {
      username
      email
      logs {name}
    }
  }

  mutation {
    createLog(userId: 1, name: "Piano", logType: "FLOAT") {
       name
    }
  }


  query {
    listLogs {
      name
      id
      userId
      logType
    }
  }

  query {
  logsForUser(userId: 1) {
    name
    id
    userId
    logType
    }
  }


  mutation {
    createEvent(logId: 1, value: 77) {
       quantity
    }
  }

  query {
    listEventsForLog(logId: 1) {
      id
      value
      insertedAt
    }
  }

  query {
    listEvents {
      id
      logId
      value
    }
  }



  """

end

