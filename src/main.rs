// This file should be renamed to lib.rs if you are authoring a library.

fn main() {
    println!("Hello world!");
}

#[cfg(test)]
mod tests {
    #[test]
    fn test() {
        assert_eq!(true, true);
    }
}
