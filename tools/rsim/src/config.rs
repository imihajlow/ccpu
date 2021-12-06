use std::fs::File;
use serde::Deserialize;
use serde_yaml;

#[derive(Debug, Deserialize)]
#[serde(deny_unknown_fields)]
pub struct Config {
    #[serde(rename = "mem")]
    mem_config: MemConfig,
    #[serde(rename = "vga")]
    vga_config: VgaConfig,
    #[serde(rename = "keyboard")]
    kb_config: KbConfig,
    #[serde(rename = "ps2")]
    ps2_config: Ps2Config,
    #[serde(rename = "spi")]
    spi_config: SpiConfig,
    #[serde(rename = "server")]
    server_config: ServerConfig,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum MemConfig {
    Plain,
    IoRev3,
}

#[derive(Debug, Deserialize)]
pub enum VgaConfig {
    #[serde(rename = "absent")]
    Absent,
    #[serde(rename = "font")]
    PresentWithFontPath(std::path::PathBuf),
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum KbConfig {
    Absent,
    Present,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum Ps2Config {
    Absent,
    Present,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum SpiConfig {
    Absent,
    Present,
}

#[derive(Debug, Deserialize)]
pub enum ServerConfig {
    #[serde(rename = "disabled")]
    Disabled,
    #[serde(rename = "port")]
    EnabledOnPort(u16)
}

#[derive(Debug)]
pub enum ConfigError {
    IoError(std::io::Error),
    ParseError(serde_yaml::Error),
}

impl From<std::io::Error> for ConfigError {
    fn from(error: std::io::Error) -> Self {
        ConfigError::IoError(error)
    }
}

impl From<serde_yaml::Error> for ConfigError {
    fn from(error: serde_yaml::Error) -> Self {
        ConfigError::ParseError(error)
    }
}

impl Config {
    pub fn new(filename: &str) -> Result<Self, ConfigError> {
        let f = File::open(filename)?;
        let mut r : Self = serde_yaml::from_reader(f)?;
        if let VgaConfig::PresentWithFontPath(ref mut path) = r.vga_config {
            use std::path::PathBuf;
            let config_path = PathBuf::from(filename); 
            let mut config_dir = config_path.parent().unwrap().to_path_buf();
            config_dir.push(PathBuf::clone(path));
            *path = config_dir;
        }
        Ok(r)
    }

    pub fn get_mem_config(&self) -> &MemConfig {
        &self.mem_config
    }

    pub fn get_vga_config(&self) -> &VgaConfig {
        &self.vga_config
    }

    pub fn get_kb_config(&self) -> &KbConfig {
        &self.kb_config
    }

    pub fn get_ps2_config(&self) -> &Ps2Config {
        &self.ps2_config
    }

    pub fn get_spi_config(&self) -> &SpiConfig {
        &self.spi_config
    }

    pub fn get_server_config(&self) -> &ServerConfig {
        &self.server_config
    }
}