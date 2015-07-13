lists = [
  {category: "apartments",
   created_by: "ronald mcdonald"},
  {category: "groceries",
   created_by: "billy bob"},
  {category: "pets",
   created_by: "obama"}
]

tasks = [
  {name: "buy an apartment",
   list_id: 1},
  {name: "buy a grocery store",
   list_id: 2},
  {name: "buy a tiger",
   list_id: 3}
]

lists.each do |list|
  List.create(list)
end

tasks.each do |task|
  Task.create(task)
end
