defmodule SeekerTest do
  use Seeker.DataCase

  alias Seeker.Integration.SeekerApp
  alias Seeker.Schemas.{Category, Post}

  describe "all/2" do
    test "retrieves records for `eq` predicate" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, _category} = Repo.insert(%Category{name: "Bar"})

      params = %{q: %{name_eq: "Foo"}}
      results = SeekerApp.all(Category, params)
      assert results == [category1]
    end

    test "retrieves records for `not_eq` predicate" do
      {:ok, _category} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})

      params = %{q: %{name_not_eq: "Foo"}}
      results = SeekerApp.all(Category, params)
      assert results == [category2]
    end

    test "retrieves records for `in` predicate" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, _category} = Repo.insert(%Category{name: "Taz"})

      params = %{q: %{name_in: ["Foo", "Bar"]}}
      results = SeekerApp.all(Category, params)
      assert results == [category1, category2]
    end

    test "retrieves records for `not_in` predicate" do
      {:ok, _category} = Repo.insert(%Category{name: "Foo"})
      {:ok, _category} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Taz"})

      params = %{q: %{name_not_in: ["Foo", "Bar"]}}
      results = SeekerApp.all(Category, params)
      assert results == [category3]
    end

    test "retrieves records for `cont` predicate" do
      {:ok, _category} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Taz"})

      params = %{q: %{name_cont: "a"}}
      results = SeekerApp.all(Category, params)
      assert results == [category2, category3]
    end

    test "retrieves records for `not_cont` predicate" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, _category} = Repo.insert(%Category{name: "Bar"})
      {:ok, _category} = Repo.insert(%Category{name: "Taz"})

      params = %{q: %{name_not_cont: "a"}}
      results = SeekerApp.all(Category, params)
      assert results == [category1]
    end

    test "retrieves records for `i_cont` predicate" do
      {:ok, _category} = Repo.insert(%Category{name: "FOO"})
      {:ok, category2} = Repo.insert(%Category{name: "BAR"})
      {:ok, category3} = Repo.insert(%Category{name: "TAZ"})

      params = %{q: %{name_i_cont: "a"}}
      results = SeekerApp.all(Category, params)
      assert results == [category2, category3]
    end

    test "retrieves records for `not_i_cont` predicate" do
      {:ok, category1} = Repo.insert(%Category{name: "FOO"})
      {:ok, _category} = Repo.insert(%Category{name: "BAR"})
      {:ok, _category} = Repo.insert(%Category{name: "TAZ"})

      params = %{q: %{name_not_i_cont: "a"}}
      results = SeekerApp.all(Category, params)
      assert results == [category1]
    end

    test "retrieves records for `start` predicate" do
      {:ok, _category} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Tar"})
      {:ok, category3} = Repo.insert(%Category{name: "Taz"})

      params = %{q: %{name_start: "Ta"}}
      results = SeekerApp.all(Category, params)
      assert results == [category2, category3]
    end

    test "retrieves records for `not_start` predicate" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, _category} = Repo.insert(%Category{name: "Tar"})
      {:ok, _category} = Repo.insert(%Category{name: "Taz"})

      params = %{q: %{name_not_start: "Ta"}}
      results = SeekerApp.all(Category, params)
      assert results == [category1]
    end

    test "retrieves records for `end` predicate" do
      {:ok, _category} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Tar"})

      params = %{q: %{name_end: "ar"}}
      results = SeekerApp.all(Category, params)
      assert results == [category2, category3]
    end

    test "retrieves records for `not_end` predicate" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, _category} = Repo.insert(%Category{name: "Bar"})
      {:ok, _category} = Repo.insert(%Category{name: "Tar"})

      params = %{q: %{name_not_end: "ar"}}
      results = SeekerApp.all(Category, params)
      assert results == [category1]
    end

    test "retrieves records for `gt` predicate" do
      date1 = DateTime.utc_now() |> DateTime.add(-60) |> DateTime.truncate(:second)
      date2 = DateTime.utc_now() |> DateTime.truncate(:second)
      date3 = DateTime.utc_now() |> DateTime.add(60) |> DateTime.truncate(:second)
      {:ok, _post} = Repo.insert(%Post{date: date1})
      {:ok, _post} = Repo.insert(%Post{date: date2})
      {:ok, post3} = Repo.insert(%Post{date: date3})

      params = %{q: %{date_gt: date2}}
      results = SeekerApp.all(Post, params)
      assert results == [post3]
    end

    test "retrieves records for `gteq` predicate" do
      date1 = DateTime.utc_now() |> DateTime.add(-60) |> DateTime.truncate(:second)
      date2 = DateTime.utc_now() |> DateTime.truncate(:second)
      date3 = DateTime.utc_now() |> DateTime.add(60) |> DateTime.truncate(:second)
      {:ok, _post} = Repo.insert(%Post{date: date1})
      {:ok, post2} = Repo.insert(%Post{date: date2})
      {:ok, post3} = Repo.insert(%Post{date: date3})

      params = %{q: %{date_gteq: date2}}
      results = SeekerApp.all(Post, params)
      assert results == [post2, post3]
    end

    test "retrieves records for `lt` predicate" do
      date1 = DateTime.utc_now() |> DateTime.add(-60) |> DateTime.truncate(:second)
      date2 = DateTime.utc_now() |> DateTime.truncate(:second)
      date3 = DateTime.utc_now() |> DateTime.add(60) |> DateTime.truncate(:second)
      {:ok, post1} = Repo.insert(%Post{date: date1})
      {:ok, _post} = Repo.insert(%Post{date: date2})
      {:ok, _post} = Repo.insert(%Post{date: date3})

      params = %{q: %{date_lt: date2}}
      results = SeekerApp.all(Post, params)
      assert results == [post1]
    end

    test "retrieves records for `lteq` predicate" do
      date1 = DateTime.utc_now() |> DateTime.add(-60) |> DateTime.truncate(:second)
      date2 = DateTime.utc_now() |> DateTime.truncate(:second)
      date3 = DateTime.utc_now() |> DateTime.add(60) |> DateTime.truncate(:second)
      {:ok, post1} = Repo.insert(%Post{date: date1})
      {:ok, post2} = Repo.insert(%Post{date: date2})
      {:ok, _post} = Repo.insert(%Post{date: date3})

      params = %{q: %{date_lteq: date2}}
      results = SeekerApp.all(Post, params)
      assert results == [post1, post2]
    end
  end
end
