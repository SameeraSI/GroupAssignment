import {*} with "./graph.jac";

walker create_familytree {
    // creates a familytree from a json file
    has data_file = "familytree.json";
    has famly_members = [];

    root {
        families = file.load_json(data_file)["families"];
        for family in families {
            spawn here ++> node::family_root(
                id = family["uid"],
                family_name = family["family_name"]
            );
        }
        take-->node::family_root;
    }

    family_root {
        family_id = here.id;
        members = file.load_json(data_file)["members"];
        filtered_members = [];
        for member in members {
            if (member["family_id"] == family_id) {
                filtered_members.list::append(member);
            }
        }

//sssssssssssssssssssssssssss

























//ssssssssssssssssssssssssssssssss
walker movie{
    has anchor ml=[];
    has ppl=[];
    has lis=[];
    has anchor new_lis=[];
    has i=1;
    has x=0;

    root: take-->node::family_root;
    family_root: take-->node::person;
    person {
        ppl.list::append([here.favourite_movie_catagory,here.name]);
        if (i==1){ ml.list::append(here.favourite_movie_catagory);}
        i=0;
        for m in ml{
            if (m == here.favourite_movie_catagory): x=1;
        }
        if (x==0):ml.list::append(here.favourite_movie_catagory);
        x=0;
            //else:
                //ml.list::append(here.favourite_movie_catagory);
            //else:
              //  ml.list::append(here.favourite_movie_catagory);
        
        //if (here.favourite_movie_catagory in ml):continue;
        //else:
        //    ml.list::append(here.favourite_movie_catagory);
    }
    with exit{
        // for m in ml{
        //     lis=[m];
        //     for p in ppl{
        //         if (m==p[0]){lis.list::append(p[1]);}
        //     }
        //     new_lis.list::append(lis);
        // }
        // std.out(new_lis);
        report ml;
    }
}




