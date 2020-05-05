defmodule Phoenix.LiveDashboard.RouterTest do
  use ExUnit.Case, async: true

  alias Phoenix.LiveDashboard.Router

  test "sets options" do
    assert Router.__options__([]) == [
             session: {Phoenix.LiveDashboard.Router, :__session__, [nil, nil]},
             layout: {Phoenix.LiveDashboard.LayoutView, :dash},
             as: :live_dashboard
           ]
  end

  test "normalizes metrics option" do
    assert Router.__options__(metrics: Foo)[:session] ==
             {Phoenix.LiveDashboard.Router, :__session__, [{Foo, :metrics}, nil]}

    assert Router.__options__(metrics: {Foo, :bar})[:session] ==
             {Phoenix.LiveDashboard.Router, :__session__, [{Foo, :bar}, nil]}

    assert_raise ArgumentError, fn ->
      Router.__options__(metrics: [])
    end
  end

  test "accepts environment option" do
    assert Router.__options__(environment: ["USER", "ROOTDIR"])[:session] ==
             {Phoenix.LiveDashboard.Router, :__session__, [nil, ["USER", "ROOTDIR"]]}

    assert_raise ArgumentError, fn ->
      Router.__options__(environment: "FOO")
    end
  end
end
