use serde::Deserialize;
use serde_yaml;
use std::collections::HashMap;
use std::fmt;
use std::io;

pub struct SymMap {
    labels: Vec<(Symbol, u16)>,
    lines: Vec<(LineInfo, u16)>,
}

#[derive(Clone, Debug)]
pub enum Symbol {
    Global(String),
    Local(String, String),
}

#[derive(Clone, Debug)]
pub struct LineInfo {
    filename: String,
    line: u32,
}

#[derive(Debug)]
pub enum SymMapLoadError {
    IoError(io::Error),
    ParseError(serde_yaml::Error),
}

impl From<io::Error> for SymMapLoadError {
    fn from(error: io::Error) -> Self {
        SymMapLoadError::IoError(error)
    }
}

impl From<serde_yaml::Error> for SymMapLoadError {
    fn from(error: serde_yaml::Error) -> Self {
        SymMapLoadError::ParseError(error)
    }
}

impl fmt::Display for Symbol {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Symbol::Global(label) => write!(f, "{}", label),
            Symbol::Local(file, label) => write!(f, "{} ({})", label, file),
        }
    }
}

impl fmt::Display for LineInfo {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}:{}", self.filename, self.line)
    }
}

#[derive(Debug, Deserialize)]
struct SymMapRepr {
    labels: HashMap<Option<String>, HashMap<String, u16>>,
    lines: HashMap<String, HashMap<u32, u16>>,
}

impl SymMap {
    pub fn load<T: io::Read>(f: &mut T) -> Result<SymMap, SymMapLoadError> {
        let mut result = SymMap {
            labels: Vec::new(),
            lines: Vec::new(),
        };

        let de: SymMapRepr = serde_yaml::from_reader(f)?;

        for (file, symbols) in de.labels {
            for (symbol, address) in symbols {
                let sym = match file {
                    Some(ref f) => Symbol::Local(f.clone(), symbol),
                    None => Symbol::Global(symbol),
                };
                result.labels.push((sym, address));
            }
        }

        for (file, lines) in de.lines {
            for (line, address) in lines {
                result.lines.push((
                    LineInfo {
                        filename: file.clone(),
                        line: line,
                    },
                    address,
                ));
            }
        }

        result.labels.sort_unstable_by(|(_, a), (_, b)| a.cmp(b));
        result.lines.sort_unstable_by(|(_, a), (_, b)| a.cmp(b));
        Ok(result)
    }

    pub fn find_symbol(&self, name: &str) -> Vec<&(Symbol, u16)> {
        self.labels
            .iter()
            .filter(|(sym, _)| match sym {
                Symbol::Global(n) => n.ends_with(name),
                Symbol::Local(_, n) => n.ends_with(name),
            })
            .collect()
    }

    pub fn find_exact_global_symbol(&self, name: &str) -> Option<u16> {
        self.labels.iter().find_map(|(sym, addr)| match sym {
            Symbol::Global(n) if name == n => Some(*addr),
            _ => None,
        })
    }

    pub fn find_line(&self, filename: &str, line: u32) -> Vec<&(LineInfo, u16)> {
        self.lines
            .iter()
            .filter(
                |(
                    LineInfo {
                        filename: fname,
                        line: ln,
                    },
                    _,
                )| *ln == line && fname.ends_with(filename),
            )
            .collect()
    }

    pub fn associate_address(&self, address: u16) -> Option<(Symbol, u16)> {
        match self.labels.binary_search_by(|(_, a)| a.cmp(&address)) {
            Ok(n) => {
                let (name, _) = &self.labels[n];
                Some((name.clone(), 0))
            }
            Err(0) => None,
            Err(n) => {
                let (name, sym_addr) = &self.labels[n - 1];
                Some((name.clone(), address - sym_addr))
            }
        }
    }

    pub fn associate_line(&self, address: u16) -> Option<(&String, u32)> {
        match self.lines.binary_search_by(|(_, a)| a.cmp(&address)) {
            Ok(n) => {
                let (li, _) = &self.lines[n];
                Some((&li.filename, li.line))
            }
            _ => None,
        }
    }
}
