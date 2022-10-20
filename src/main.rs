// This file should be renamed to lib.rs if you are authoring a library.

fn main() {
    println!("Hello world!");
}

#[cfg(test)]
mod tests {
    use crate::main;

    #[test]
    fn test() {
        main();
        assert_eq!(true, true);
    }
}
