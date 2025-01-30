defmodule SeekerTest do
  use Seeker.DataCase

  import Ecto.Query, warn: false

  alias Seeker.Integration.SeekerApp
  alias Seeker.Schemas.{Category, Post}

  describe "all/2" do
    test "ignores value when it is empty" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})

      params = %{q: %{name_eq: ""}}
      results = SeekerApp.all(Category, params)
      assert results == [category1, category2]
    end

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

    test "retrieves records for `btwn` predicate" do
      date1 = DateTime.utc_now() |> DateTime.add(-60) |> DateTime.truncate(:second)
      date2 = DateTime.utc_now() |> DateTime.truncate(:second)
      date3 = DateTime.utc_now() |> DateTime.add(60) |> DateTime.truncate(:second)
      {:ok, _post} = Repo.insert(%Post{date: date1})
      {:ok, post2} = Repo.insert(%Post{date: date2})
      {:ok, _post} = Repo.insert(%Post{date: date3})

      first_date = DateTime.utc_now() |> DateTime.add(-30) |> DateTime.truncate(:second)
      last_date  = DateTime.utc_now() |> DateTime.add(30)  |> DateTime.truncate(:second)

      params = %{q: %{date_between: [first_date, last_date]}}
      results = SeekerApp.all(Post, params)
      assert results == [post2]
    end

    test "retrieves records for `eq` predicate in belongs to association" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, post1} = Repo.insert(%Post{category: category1})
      {:ok, _post} = Repo.insert(%Post{category: category2})

      params = %{q: %{category__name_eq: "Foo"}}
      query = from(p in Post, preload: [:category])
      results = SeekerApp.all(query, params)
      assert results == [post1]
    end

    test "raises error when predicate does not exist" do
      assert_raise Seeker.PredicateNotFoundError, fn ->
        params = %{q: %{name_invalid: "Foo"}}
        SeekerApp.all(Category, params)
      end
    end

    test "retrieves records sorted by one column with default direction" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Tar"})

      params = %{s: "id"}
      results = SeekerApp.all(Category, params)
      assert results == [category1, category2, category3]
    end

    test "retrieves records sorted by one column with asc direction" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Tar"})

      params = %{s: "name+asc"}
      results = SeekerApp.all(Category, params)
      assert results == [category2, category1, category3]
    end

    test "retrieves records sorted by one column with desc direction" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Tar"})

      params = %{s: "id+desc"}
      results = SeekerApp.all(Category, params)
      assert results == [category3, category2, category1]
    end

    test "retrieves records sorted with multiple sorts" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Bar"})
      {:ok, category4} = Repo.insert(%Category{name: "Tar"})

      params = %{s: "name,id+desc"}
      results = SeekerApp.all(Category, params)
      assert results == [category3, category2, category1, category4]
    end

    test "retrieves unordered records when empty sort param" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Tar"})

      params = %{s: ""}
      results = SeekerApp.all(Category, params)
      assert results == [category1, category2, category3]
    end

    test "retrieves records sorted when empty sort segments" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Bar"})

      params = %{s: ",,name,id+desc,"}
      results = SeekerApp.all(Category, params)
      assert results == [category3, category2, category1]
    end

    test "retrieves records sorted by one column of an association" do
      {:ok, category1} = Repo.insert(%Category{name: "Foo"})
      {:ok, category2} = Repo.insert(%Category{name: "Bar"})
      {:ok, category3} = Repo.insert(%Category{name: "Tar"})
      {:ok, post1} = Repo.insert(%Post{category: category1})
      {:ok, post2} = Repo.insert(%Post{category: category2})
      {:ok, post3} = Repo.insert(%Post{category: category3})

      params = %{s: "category__name+asc"}
      query = from(p in Post, preload: [:category])
      results = SeekerApp.all(query, params)
      assert results == [post2, post1, post3]
    end
  end
end
