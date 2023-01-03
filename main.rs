#[derive(Debug)]
struct Person {
    name: String,
    age: i32
}

fn age(number: i32) -> (Option<i32>, Vec<String>) {
    if number > 0 {
        return (Some(number), vec![]);
    }
    else {
        return (None, vec![String::from("error")]);
    }
}

fn name(name: String) -> (Option<String>, Vec<String>) {
    if name == String::from("abc") {
        return (Some(name), vec![]);
    }
    else {
        return (None, vec![String::from("error")]);
    }
}


fn main() {
    let (age, errors) = age(-1);
    let (name, second_errors) = name(String::from("abc"));
    
    match (age, name) {
        (Some(age), Some(name)) => {
            let person: Person = Person {
                name: name,
                age: age
            };
            println!("{:?}", person);
        },
        _ => {
            println!("{:?}, {:?}", errors, second_errors);
        }
    }
}
