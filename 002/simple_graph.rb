class SimpleGraph
    Vertex = Struct.new(:edges)
    Edge = Struct.new(:vertex1, :vertex2)
    
    def initialize(num_vertices)
        @edges = []
        @vertices = []
        num_vertices.times { @vertices << Vertex.new([]) }
    end
        
    def add_vertex
        @vertices << Vertex.new([])
    end
    
    def add_edge(vertex1, vertex2)
        edge = Edge.new(vertex1, vertex2)
        @edges << edge
        @vertices[vertex1].edges << edge
        @vertices[vertex2].edges << edge
    end

    def find_directed_path(source, destination)
        visited = [nil] * @vertices.length
        visited[source] = Edge.new(nil, nil)  # dummy, so we don't visit the source twice
        queue = [source]
        
        while queue.length > 0
            current = queue.delete_at(0)
            #puts current
            
            if current == destination
                path = []
                while not (current == source)
                    path << visited[current]
                    current = visited[current].vertex1
                end
                return path.reverse
            end
            
            @vertices[current].edges.each do |edge|
                if visited[edge.vertex2] == nil  # vertex2 was not visited before
                    queue << edge.vertex2
                    visited[edge.vertex2] = edge
                end
            end
        end
        
        return []
    end
    
    def write_dot_file(filename, directed)
        File.open(filename, 'wb') do |file|
            if directed
                file.puts 'digraph {'
                @edges.each { |edge| file.puts('    ' + edge.vertex1.to_s + ' -> ' + edge.vertex2.to_s + ';') }
            else
                file.puts 'graph {'
                @edges.each { |edge| file.puts('    ' + edge.vertex1.to_s + ' -- ' + edge.vertex2.to_s + ';') }
            end
            file.puts '}'
        end
    end
end


if __FILE__ == $0
    test1 = SimpleGraph.new(10)

    test1.add_edge(0, 2)
    test1.add_edge(0, 4)
    test1.add_edge(0, 6)
    test1.add_edge(0, 8)

    test1.add_edge(2, 3)
    test1.add_edge(2, 5)
    test1.add_edge(4, 7)
    test1.add_edge(6, 5)
    test1.add_edge(8, 9)

    test1.add_edge(3, 1)
    test1.add_edge(5, 1)
    test1.add_edge(7, 1)
    test1.add_edge(9, 1)

    test1.write_dot_file('test1_d.dot', true)
    test1.write_dot_file('test1.dot', false)


    test2 = SimpleGraph.new(10)

    test2.add_edge(0, 2)
    test2.add_edge(0, 4)
    test2.add_edge(0, 6)
    test2.add_edge(0, 8)

    test2.add_edge(2, 5)
    test2.add_edge(4, 3)
    test2.add_edge(4, 7)
    test2.add_edge(6, 5)
    test2.add_edge(8, 7)
    test2.add_edge(8, 9)

    test2.add_edge(3, 1)
    test2.add_edge(5, 1)
    test2.add_edge(7, 1)
    test2.add_edge(9, 1)

    test2.write_dot_file('test2_d.dot', true)
    test2.write_dot_file('test2.dot', false)
    

    test3 = SimpleGraph.new(10)

    test3.add_edge(0, 2)
    test3.add_edge(0, 4)
    test3.add_edge(0, 6)
    test3.add_edge(0, 8)

    test3.add_edge(2, 3)
    test3.add_edge(2, 5)
    test3.add_edge(4, 5)
    test3.add_edge(4, 7)
    test3.add_edge(6, 7)
    test3.add_edge(6, 9)
    test3.add_edge(8, 9)

    test3.add_edge(3, 1)
    test3.add_edge(5, 1)
    test3.add_edge(7, 1)
    test3.add_edge(9, 1)

    test3.write_dot_file('test3_d.dot', true)
    test3.write_dot_file('test3.dot', false)

    
    matching = [nil] * 4
    i = 1
    while not (path = test3.find_directed_path(0, 1)).empty?
        puts path
        puts
        path.each do |edge|
            if not ((edge.vertex1 == 0) or (edge.vertex2 == 1))
                matching[edge.vertex1 / 2] = edge if (edge.vertex1 % 2) == 0
            end
            edge.vertex1, edge.vertex2 = edge.vertex2, edge.vertex1
        end
        #test2.write_dot_file('test2_' + i.to_s + '.dot', true)
        i += 1
    end
    puts matching
end

