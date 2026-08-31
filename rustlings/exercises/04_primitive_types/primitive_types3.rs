fn main() {
    // TODO: Create an array called `a` with at least 100 elements in it from 1 to 100 dont write manually.
    let a = (0..100).collect::<std::vec::Vec<i32>>();

    if a.len() >= 100 {
        println!("Wow, that's a big array!");
        // TODO: print whole array.
        println!("{:?}", a);
    } else {
        println!("Meh, I eat arrays like that for breakfast.");
        panic!("Array not big enough, more elements needed");
    }
}
