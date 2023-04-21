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
        for member in filtered_members {
            family_member = spawn here +[member]+> node::person(
                id = member["uid"],
                family_id = member["family_id"],
                name = member["name"],
                date_of_birth = member["date_of_birth"],
                profession = member["profession"],
                gender = member["gender"],
                deceased = member["deceased"],
                parents = member["parents"],
                children = member["children"],
                spouse = member["spouse"],
                favourite_movie_catagory = member["favourite_movie_catagory"]
                
            );
            famly_members.list::append(family_member);
        }
    }

    with exit {
        for member_1 in famly_members {
            for member_2 in famly_members {
                if (member_1.id  == member_2.id): continue;
                if (member_1.spouse == member_2.id and member_2.spouse == member_1.id) {
                    member_1 +[married]+> member_2;
                }
                if (member_1.id in member_2.children): member_1 +[child]+> member_2;
            }
        }
    }
}


walker male_lists{
    has anchor male_list=[];
    root: take-->node::family_root;
    family_root: take-->node::person;
    person {
        if (here.gender=="Male"){
        male_list.list::append(here.name);}

    }
    with exit{
        report male_list;
    }



}


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
