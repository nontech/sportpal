defmodule Sportpal.InquiriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sportpal.Inquiries.Inquiries` context.
  """

  @doc """
  Generate a inquiry.
  """
  def inquiry_fixture(attrs \\ %{}) do
    {:ok, inquiry} =
      attrs
      |> Enum.into(%{})
      |> Sportpal.Inquiries.Inquiries.create_inquiry()

    inquiry
  end
end
