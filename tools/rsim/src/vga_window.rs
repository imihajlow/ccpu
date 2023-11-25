use crate::ps2::Ps2;
use crate::vga::Vga;
use minifb::{Key, KeyRepeat, Window, WindowOptions};
use std::sync::mpsc;
use std::sync::Arc;
use std::sync::Mutex;

const WIDTH: usize = 640;
const HEIGHT: usize = 480;

pub struct VgaWindow {
    vga: Arc<Mutex<Vga>>,
    ps2: Option<Arc<Mutex<Ps2>>>,
}

impl VgaWindow {
    pub fn new(vga: Option<Arc<Mutex<Vga>>>, ps2: Option<Arc<Mutex<Ps2>>>) -> Option<Self> {
        let vga = vga?;
        Some(VgaWindow { vga, ps2 })
    }

    pub fn run(&self, terminate_signal: mpsc::Receiver<()>) {
        let mut buffer: Vec<u32> = vec![0; WIDTH * HEIGHT];
        let mut window = Window::new("VGA", WIDTH, HEIGHT, WindowOptions::default())
            .unwrap_or_else(|e| {
                panic!("{}", e);
            });

        window.limit_update_rate(Some(std::time::Duration::from_micros(16600)));

        while window.is_open() {
            self.push_released_keys(window.get_keys_released());
            self.push_pressed_keys(window.get_keys_pressed(KeyRepeat::Yes));
            self.vga.lock().unwrap().render_to_buffer(&mut buffer);
            window.update_with_buffer(&buffer, WIDTH, HEIGHT).unwrap();

            match terminate_signal.try_recv() {
                Ok(()) => break,
                Err(mpsc::TryRecvError::Empty) => {}
                Err(e) => {
                    println!("{}", e);
                    break;
                }
            }
        }
    }

    fn push_pressed_keys(&self, keys: Vec<Key>) {
        if let Some(ps2) = self.ps2.as_ref() {
            let mut ps2 = ps2.lock().unwrap();
            for key in keys {
                match key {
                    Key::Key0 => ps2.push_many(&[0x45]),
                    Key::Key1 => ps2.push_many(&[0x16]),
                    Key::Key2 => ps2.push_many(&[0x1e]),
                    Key::Key3 => ps2.push_many(&[0x26]),
                    Key::Key4 => ps2.push_many(&[0x25]),
                    Key::Key5 => ps2.push_many(&[0x2e]),
                    Key::Key6 => ps2.push_many(&[0x36]),
                    Key::Key7 => ps2.push_many(&[0x3d]),
                    Key::Key8 => ps2.push_many(&[0x3e]),
                    Key::Key9 => ps2.push_many(&[0x46]),
                    Key::A => ps2.push_many(&[0x1c]),
                    Key::B => ps2.push_many(&[0x32]),
                    Key::C => ps2.push_many(&[0x21]),
                    Key::D => ps2.push_many(&[0x23]),
                    Key::E => ps2.push_many(&[0x24]),
                    Key::F => ps2.push_many(&[0x2b]),
                    Key::G => ps2.push_many(&[0x34]),
                    Key::H => ps2.push_many(&[0x33]),
                    Key::I => ps2.push_many(&[0x43]),
                    Key::J => ps2.push_many(&[0x3b]),
                    Key::K => ps2.push_many(&[0x42]),
                    Key::L => ps2.push_many(&[0x4b]),
                    Key::M => ps2.push_many(&[0x3a]),
                    Key::N => ps2.push_many(&[0x31]),
                    Key::O => ps2.push_many(&[0x44]),
                    Key::P => ps2.push_many(&[0x4d]),
                    Key::Q => ps2.push_many(&[0x15]),
                    Key::R => ps2.push_many(&[0x2d]),
                    Key::S => ps2.push_many(&[0x1b]),
                    Key::T => ps2.push_many(&[0x2c]),
                    Key::U => ps2.push_many(&[0x3c]),
                    Key::V => ps2.push_many(&[0x2a]),
                    Key::W => ps2.push_many(&[0x1d]),
                    Key::X => ps2.push_many(&[0x22]),
                    Key::Y => ps2.push_many(&[0x35]),
                    Key::Z => ps2.push_many(&[0x1a]),
                    Key::F1 => ps2.push_many(&[0x05]),
                    Key::F2 => ps2.push_many(&[0x06]),
                    Key::F3 => ps2.push_many(&[0x04]),
                    Key::F4 => ps2.push_many(&[0x0c]),
                    Key::F5 => ps2.push_many(&[0x03]),
                    Key::F6 => ps2.push_many(&[0x0b]),
                    Key::F7 => ps2.push_many(&[0x83]),
                    Key::F8 => ps2.push_many(&[0x0a]),
                    Key::F9 => ps2.push_many(&[0x01]),
                    Key::F10 => ps2.push_many(&[0x09]),
                    Key::F11 => ps2.push_many(&[0x78]),
                    Key::F12 => ps2.push_many(&[0x07]),
                    Key::F13 => (),
                    Key::F14 => (),
                    Key::F15 => (),
                    Key::Down => ps2.push_many(&[0xe0, 0x72]),
                    Key::Left => ps2.push_many(&[0xe0, 0x6b]),
                    Key::Right => ps2.push_many(&[0xe0, 0x74]),
                    Key::Up => ps2.push_many(&[0xe0, 0x75]),
                    Key::Apostrophe => ps2.push_many(&[0x52]),
                    Key::Backquote => ps2.push_many(&[0x0e]),
                    Key::Backslash => ps2.push_many(&[0x5d]),
                    Key::Comma => ps2.push_many(&[0x41]),
                    Key::Equal => ps2.push_many(&[0x55]),
                    Key::LeftBracket => ps2.push_many(&[0x54]),
                    Key::Minus => ps2.push_many(&[0x4e]),
                    Key::Period => ps2.push_many(&[0x49]),
                    Key::RightBracket => ps2.push_many(&[0x5b]),
                    Key::Semicolon => ps2.push_many(&[0x4c]),
                    Key::Slash => ps2.push_many(&[0x4a]),
                    Key::Backspace => ps2.push_many(&[0x66]),
                    Key::Delete => ps2.push_many(&[0xe0, 0x71]),
                    Key::End => ps2.push_many(&[0xe0, 0x69]),
                    Key::Enter => ps2.push_many(&[0x5a]),
                    Key::Escape => ps2.push_many(&[0x76]),
                    Key::Home => ps2.push_many(&[0xe0, 0x6c]),
                    Key::Insert => ps2.push_many(&[0xe0, 0x70]),
                    Key::Menu => ps2.push_many(&[0xe0, 0x2f]),
                    Key::PageDown => ps2.push_many(&[0xe0, 0x7a]),
                    Key::PageUp => ps2.push_many(&[0xe0, 0x7d]),
                    Key::Pause => ps2.push_many(&[0xe1, 0x14, 0x77, 0xe1, 0xf0, 0x14, 0xe0, 0x77]),
                    Key::Space => ps2.push_many(&[0x29]),
                    Key::Tab => ps2.push_many(&[0x0d]),
                    Key::NumLock => ps2.push_many(&[0x77]),
                    Key::CapsLock => ps2.push_many(&[0x58]),
                    Key::ScrollLock => ps2.push_many(&[0x7e]),
                    Key::LeftShift => ps2.push_many(&[0x12]),
                    Key::RightShift => ps2.push_many(&[0x59]),
                    Key::LeftCtrl => ps2.push_many(&[0x14]),
                    Key::RightCtrl => ps2.push_many(&[0xe0, 0x14]),
                    Key::NumPad0 => ps2.push_many(&[0x70]),
                    Key::NumPad1 => ps2.push_many(&[0x69]),
                    Key::NumPad2 => ps2.push_many(&[0x72]),
                    Key::NumPad3 => ps2.push_many(&[0x7a]),
                    Key::NumPad4 => ps2.push_many(&[0x6b]),
                    Key::NumPad5 => ps2.push_many(&[0x73]),
                    Key::NumPad6 => ps2.push_many(&[0x74]),
                    Key::NumPad7 => ps2.push_many(&[0x6c]),
                    Key::NumPad8 => ps2.push_many(&[0x75]),
                    Key::NumPad9 => ps2.push_many(&[0x7d]),
                    Key::NumPadDot => ps2.push_many(&[0x71]),
                    Key::NumPadSlash => ps2.push_many(&[0xe0, 0x4a]),
                    Key::NumPadAsterisk => ps2.push_many(&[0x7c]),
                    Key::NumPadMinus => ps2.push_many(&[0x7b]),
                    Key::NumPadPlus => ps2.push_many(&[0x79]),
                    Key::NumPadEnter => ps2.push_many(&[0xe0, 0x5a]),
                    Key::LeftAlt => ps2.push_many(&[0x11]),
                    Key::RightAlt => ps2.push_many(&[0xe0, 0x11]),
                    Key::LeftSuper => ps2.push_many(&[0xe0, 0x1f]),
                    Key::RightSuper => ps2.push_many(&[0xe0, 0x27]),
                    _ => (),
                }
            }
        }
    }

    fn push_released_keys(&self, keys: Vec<Key>) {
        if let Some(ps2) = self.ps2.as_ref() {
            let mut ps2 = ps2.lock().unwrap();
            for key in keys {
                match key {
                    Key::Key0 => ps2.push_many(&[0xf0, 0x45]),
                    Key::Key1 => ps2.push_many(&[0xf0, 0x16]),
                    Key::Key2 => ps2.push_many(&[0xf0, 0x1e]),
                    Key::Key3 => ps2.push_many(&[0xf0, 0x26]),
                    Key::Key4 => ps2.push_many(&[0xf0, 0x25]),
                    Key::Key5 => ps2.push_many(&[0xf0, 0x2e]),
                    Key::Key6 => ps2.push_many(&[0xf0, 0x36]),
                    Key::Key7 => ps2.push_many(&[0xf0, 0x3d]),
                    Key::Key8 => ps2.push_many(&[0xf0, 0x3e]),
                    Key::Key9 => ps2.push_many(&[0xf0, 0x46]),
                    Key::A => ps2.push_many(&[0xf0, 0x1c]),
                    Key::B => ps2.push_many(&[0xf0, 0x32]),
                    Key::C => ps2.push_many(&[0xf0, 0x21]),
                    Key::D => ps2.push_many(&[0xf0, 0x23]),
                    Key::E => ps2.push_many(&[0xf0, 0x24]),
                    Key::F => ps2.push_many(&[0xf0, 0x2b]),
                    Key::G => ps2.push_many(&[0xf0, 0x34]),
                    Key::H => ps2.push_many(&[0xf0, 0x33]),
                    Key::I => ps2.push_many(&[0xf0, 0x43]),
                    Key::J => ps2.push_many(&[0xf0, 0x3b]),
                    Key::K => ps2.push_many(&[0xf0, 0x42]),
                    Key::L => ps2.push_many(&[0xf0, 0x4b]),
                    Key::M => ps2.push_many(&[0xf0, 0x3a]),
                    Key::N => ps2.push_many(&[0xf0, 0x31]),
                    Key::O => ps2.push_many(&[0xf0, 0x44]),
                    Key::P => ps2.push_many(&[0xf0, 0x4d]),
                    Key::Q => ps2.push_many(&[0xf0, 0x15]),
                    Key::R => ps2.push_many(&[0xf0, 0x2d]),
                    Key::S => ps2.push_many(&[0xf0, 0x1b]),
                    Key::T => ps2.push_many(&[0xf0, 0x2c]),
                    Key::U => ps2.push_many(&[0xf0, 0x3c]),
                    Key::V => ps2.push_many(&[0xf0, 0x2a]),
                    Key::W => ps2.push_many(&[0xf0, 0x1d]),
                    Key::X => ps2.push_many(&[0xf0, 0x22]),
                    Key::Y => ps2.push_many(&[0xf0, 0x35]),
                    Key::Z => ps2.push_many(&[0xf0, 0x1a]),
                    Key::F1 => ps2.push_many(&[0xf0, 0x05]),
                    Key::F2 => ps2.push_many(&[0xf0, 0x06]),
                    Key::F3 => ps2.push_many(&[0xf0, 0x04]),
                    Key::F4 => ps2.push_many(&[0xf0, 0x0c]),
                    Key::F5 => ps2.push_many(&[0xf0, 0x03]),
                    Key::F6 => ps2.push_many(&[0xf0, 0x0b]),
                    Key::F7 => ps2.push_many(&[0xf0, 0x83]),
                    Key::F8 => ps2.push_many(&[0xf0, 0x0a]),
                    Key::F9 => ps2.push_many(&[0xf0, 0x01]),
                    Key::F10 => ps2.push_many(&[0xf0, 0x09]),
                    Key::F11 => ps2.push_many(&[0xf0, 0x78]),
                    Key::F12 => ps2.push_many(&[0xf0, 0x07]),
                    Key::F13 => (),
                    Key::F14 => (),
                    Key::F15 => (),
                    Key::Down => ps2.push_many(&[0xe0, 0xf0, 0x72]),
                    Key::Left => ps2.push_many(&[0xe0, 0xf0, 0x6b]),
                    Key::Right => ps2.push_many(&[0xe0, 0xf0, 0x74]),
                    Key::Up => ps2.push_many(&[0xe0, 0xf0, 0x75]),
                    Key::Apostrophe => ps2.push_many(&[0xf0, 0x52]),
                    Key::Backquote => ps2.push_many(&[0xf0, 0x0e]),
                    Key::Backslash => ps2.push_many(&[0xf0, 0x5d]),
                    Key::Comma => ps2.push_many(&[0xf0, 0x41]),
                    Key::Equal => ps2.push_many(&[0xf0, 0x55]),
                    Key::LeftBracket => ps2.push_many(&[0xf0, 0x54]),
                    Key::Minus => ps2.push_many(&[0xf0, 0x4e]),
                    Key::Period => ps2.push_many(&[0xf0, 0x49]),
                    Key::RightBracket => ps2.push_many(&[0xf0, 0x5b]),
                    Key::Semicolon => ps2.push_many(&[0xf0, 0x4c]),
                    Key::Slash => ps2.push_many(&[0xf0, 0x4a]),
                    Key::Backspace => ps2.push_many(&[0xf0, 0x66]),
                    Key::Delete => ps2.push_many(&[0xe0, 0xf0, 0x71]),
                    Key::End => ps2.push_many(&[0xe0, 0xf0, 0x69]),
                    Key::Enter => ps2.push_many(&[0xf0, 0x5a]),
                    Key::Escape => ps2.push_many(&[0xf0, 0x76]),
                    Key::Home => ps2.push_many(&[0xe0, 0xf0, 0x6c]),
                    Key::Insert => ps2.push_many(&[0xe0, 0xf0, 0x70]),
                    Key::Menu => ps2.push_many(&[0xe0, 0xf0, 0x2f]),
                    Key::PageDown => ps2.push_many(&[0xe0, 0xf0, 0x7a]),
                    Key::PageUp => ps2.push_many(&[0xe0, 0xf0, 0x7d]),
                    Key::Pause => (),
                    Key::Space => ps2.push_many(&[0xf0, 0x29]),
                    Key::Tab => ps2.push_many(&[0xf0, 0x0d]),
                    Key::NumLock => ps2.push_many(&[0xf0, 0x77]),
                    Key::CapsLock => ps2.push_many(&[0xf0, 0x58]),
                    Key::ScrollLock => ps2.push_many(&[0xf0, 0x7e]),
                    Key::LeftShift => ps2.push_many(&[0xf0, 0x12]),
                    Key::RightShift => ps2.push_many(&[0xf0, 0x59]),
                    Key::LeftCtrl => ps2.push_many(&[0xf0, 0x14]),
                    Key::RightCtrl => ps2.push_many(&[0xe0, 0xf0, 0x14]),
                    Key::NumPad0 => ps2.push_many(&[0xf0, 0x70]),
                    Key::NumPad1 => ps2.push_many(&[0xf0, 0x69]),
                    Key::NumPad2 => ps2.push_many(&[0xf0, 0x72]),
                    Key::NumPad3 => ps2.push_many(&[0xf0, 0x7a]),
                    Key::NumPad4 => ps2.push_many(&[0xf0, 0x6b]),
                    Key::NumPad5 => ps2.push_many(&[0xf0, 0x73]),
                    Key::NumPad6 => ps2.push_many(&[0xf0, 0x74]),
                    Key::NumPad7 => ps2.push_many(&[0xf0, 0x6c]),
                    Key::NumPad8 => ps2.push_many(&[0xf0, 0x75]),
                    Key::NumPad9 => ps2.push_many(&[0xf0, 0x7d]),
                    Key::NumPadDot => ps2.push_many(&[0xf0, 0x71]),
                    Key::NumPadSlash => ps2.push_many(&[0xe0, 0xf0, 0x4a]),
                    Key::NumPadAsterisk => ps2.push_many(&[0xf0, 0x7c]),
                    Key::NumPadMinus => ps2.push_many(&[0xf0, 0x7b]),
                    Key::NumPadPlus => ps2.push_many(&[0xf0, 0x79]),
                    Key::NumPadEnter => ps2.push_many(&[0xe0, 0xf0, 0x5a]),
                    Key::LeftAlt => ps2.push_many(&[0xf0, 0x11]),
                    Key::RightAlt => ps2.push_many(&[0xe0, 0xf0, 0x11]),
                    Key::LeftSuper => ps2.push_many(&[0xe0, 0xf0, 0x1f]),
                    Key::RightSuper => ps2.push_many(&[0xe0, 0xf0, 0x27]),
                    _ => (),
                }
            }
        }
    }
}
