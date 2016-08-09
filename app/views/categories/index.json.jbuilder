json.array!(@categories) do |category|
  json.extract! category, :id, :name
  json.url category_url(category, format: :json)
  json.groups(Group.all.joins(:platillos=>:category).where("categories.id=?",category.id).uniq) do |group|
    json.id group.id
    json.name group.name
  end
end
