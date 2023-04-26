defmodule Sportpal.Inquiries.InquiriesTest do
  use Sportpal.DataCase

  alias Sportpal.Inquiries.Inquiries

  describe "inquiries" do
    alias Sportpal.Inquiries.Inquiry

    import Sportpal.InquiriesFixtures

    @invalid_attrs %{}

    test "list_inquiries/0 returns all inquiries" do
      inquiry = inquiry_fixture()
      assert Inquiries.list_inquiries() == [inquiry]
    end

    test "get_inquiry!/1 returns the inquiry with given id" do
      inquiry = inquiry_fixture()
      assert Inquiries.get_inquiry!(inquiry.id) == inquiry
    end

    test "create_inquiry/1 with valid data creates a inquiry" do
      valid_attrs = %{}

      assert {:ok, %Inquiry{} = inquiry} = Inquiries.create_inquiry(valid_attrs)
    end

    test "create_inquiry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inquiries.create_inquiry(@invalid_attrs)
    end

    test "update_inquiry/2 with valid data updates the inquiry" do
      inquiry = inquiry_fixture()
      update_attrs = %{}

      assert {:ok, %Inquiry{} = inquiry} = Inquiries.update_inquiry(inquiry, update_attrs)
    end

    test "update_inquiry/2 with invalid data returns error changeset" do
      inquiry = inquiry_fixture()
      assert {:error, %Ecto.Changeset{}} = Inquiries.update_inquiry(inquiry, @invalid_attrs)
      assert inquiry == Inquiries.get_inquiry!(inquiry.id)
    end

    test "delete_inquiry/1 deletes the inquiry" do
      inquiry = inquiry_fixture()
      assert {:ok, %Inquiry{}} = Inquiries.delete_inquiry(inquiry)
      assert_raise Ecto.NoResultsError, fn -> Inquiries.get_inquiry!(inquiry.id) end
    end

    test "change_inquiry/1 returns a inquiry changeset" do
      inquiry = inquiry_fixture()
      assert %Ecto.Changeset{} = Inquiries.change_inquiry(inquiry)
    end
  end
end
