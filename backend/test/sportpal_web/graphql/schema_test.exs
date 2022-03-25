defmodule SportpalWeb.Graphql.SchemaTest do
  use SportpalWeb.ConnCase, async: true

  @item_query """
  query getItem($id: ID!) {
    item(id: $id) {
      id
      name
    }
  }
  """

  test "query: item", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @item_query,
        "variables" => %{id: "foo"}
      })

    assert json_response(conn, 200) == %{
             "data" => %{"item" => %{"id" => "foo", "name" => "Foo"}}
           }
  end
end
