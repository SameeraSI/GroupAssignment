// Edges
edge married;
edge child;
edge member;

// Nodes
node person {
    has id;
    has family_id;
    has name;
    has date_of_birth;
    has profession;
    has gender;
    has deceased;
    has parents;
    has children;
    has spouse;
    has favourite_movie_catagory;
    has cars;
    has f;
    

    has age;
    has days_to_birthday;


 

    
}
node family_root {
    has id;
    has family_name;
}

// Graphs
graph family_tree {
    has anchor family_root;
    spawn {
        family_root = spawn node::family_root;
    }
}
