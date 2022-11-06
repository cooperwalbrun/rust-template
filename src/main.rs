#![forbid(unsafe_code)]

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
