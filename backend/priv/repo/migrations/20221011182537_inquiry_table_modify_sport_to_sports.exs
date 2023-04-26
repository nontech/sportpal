defmodule Sportpal.Repo.Migrations.InquiryTableModifySportToSports do
  use Ecto.Migration

  def change do
    alter table(:inquiries) do
      remove :sport
      add :sports, {:array, :string}
    end
  end
end
