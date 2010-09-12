require 'simple_graph'

### This problem is a special case of the graph theory problem
### Maximum-Bipartite-Matching. A simplified network-flow algorithm
### is used to solve it.

class Array
    def shuffle!
        length.downto(1) { |n| push(delete_at(rand(n)))}
        self
    end
end

Person = Struct.new(:first_name, :last_name, :email, :santa_for)
people = []

input = gets
while not input.nil?
    #puts input.inspect
    if not input.strip.empty?
        data = input.split
        people << Person.new(data[0], data[1], data[2], nil)
    end
    input = gets
end

people.shuffle!


graph = SimpleGraph.new(2 * people.length + 2)

people.length.times do |a|
    graph.add_edge(0, 2 * (a + 1))
    graph.add_edge(2 * (a + 1) + 1, 1)
    people.length.times do |b|
        graph.add_edge(2 * (a + 1), 2 * (b + 1) + 1) if not people[a].last_name == people[b].last_name
    end
end

#graph.write_dot_file('santas.dot', true)


while not (path = graph.find_directed_path(0, 1)).empty?
    #puts path
    path.each do |edge|
        if not ((edge.vertex1 == 0) or (edge.vertex2 == 1))
            people[edge.vertex1 / 2 - 1].santa_for = people[(edge.vertex2 - 1) / 2 - 1] if (edge.vertex1 % 2) == 0
        end
        edge.vertex1, edge.vertex2 = edge.vertex2, edge.vertex1
    end
    #test2.write_dot_file('test2_' + i.to_s + '.dot', true)
end


puts 'The following (best possible) matching was found:'
people.each do |person|
    print person.first_name + ' ' + person.last_name + ' => '
    if person.santa_for
        puts person.santa_for.first_name + ' ' + person.santa_for.last_name
    else
        puts 'NO MATCH POSSIBLE'
    end
end

