use std::io;
use std::io::BufRead;
use parse_int::parse;
use parse_int;
use regex::Regex;
use core::num;


pub struct SymMap {
    by_address: Vec<(String, u16)>,
}

#[derive(Debug)]
pub enum SymMapLoadError {
    IoError(io::Error),
    ParseError(num::ParseIntError)
}

impl From<io::Error> for SymMapLoadError {
    fn from(error: io::Error) -> Self {
        SymMapLoadError::IoError(error)
    }
}

impl From<num::ParseIntError> for SymMapLoadError {
    fn from(error: num::ParseIntError) -> Self {
        SymMapLoadError::ParseError(error)
    }
}

impl SymMap {
    pub fn load<T: io::Read>(f: &mut T) -> Result<SymMap, SymMapLoadError> {
        let lines = io::BufReader::new(f).lines();
        let re = Regex::new(r"^(\w+)\s*=\s*(0x[0-9a-f]+|[1-9]\d*)\s*$").unwrap();
        let mut result = SymMap{
            by_address: Vec::new()
        };
        for line in lines {
            let l = line?;
            match re.captures(&l) {
                None => {},
                Some(cap) => {
                    let name = &cap[1];
                    let value = parse::<u16>(&cap[2])?;
                    result.by_address.push((name.to_string(), value));
                }
            };
        }
        result.by_address.sort_unstable_by(|(_,a), (_,b)| a.cmp(b));
        Ok(result)
    }

    pub fn find_symbol(&self, name: &str) -> Vec<(String, u16)> {
        self.by_address.iter()
            .filter(|(n,_)| n.ends_with(name))
            .map(|(n,a)| (n.clone(), *a))
            .collect()
    }

    pub fn associate_address(&self, address: u16) -> Option<(&String, u16)> {
        match self.by_address.binary_search_by(|(_,a)| a.cmp(&address)) {
            Ok(n) => {
                let (name, _) = &self.by_address[n];
                Some((name, 0))
            },
            Err(0) => None,
            Err(n) => {
                let (name, sym_addr) = &self.by_address[n - 1];
                Some((name, address - sym_addr))
            }
        }
    }
}
