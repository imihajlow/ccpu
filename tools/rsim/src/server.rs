use std::thread::JoinHandle;
use std::sync::mpsc;
use std::net::{IpAddr, Ipv4Addr, SocketAddr};
use mio::net::TcpListener;
use mio::net::TcpStream;
use mio::{Events, Interest, Poll, Token};
use std::time::Duration;
use std::io::BufReader;
use std::io::BufRead;
use std::io::Write;
use regex::Regex;
use crate::vga::Vga;
use std::sync::{Arc, Mutex};

pub struct Server {
    tx: mpsc::Sender<()>,
    handle: Option<JoinHandle<()>>
}

impl Server {
    pub fn start(port: u16, vga: Arc<Mutex<Vga>>) -> Self {
        let (tx,rx) = mpsc::channel();
        Server {
            tx: tx,
            handle: Some(std::thread::spawn(move || {
                if let Err(e) = serve(port, rx, vga) {
                    eprintln!("Server died: {:?}", e);
                }
            }))
        }
    }

    pub fn shutdown_and_join(&mut self) {
        self.tx.send(()).unwrap();
        if let Some(h) = self.handle.take() {
            h.join().unwrap();
        }
    }
}

fn bad_request(mut s: TcpStream) -> std::io::Result<()> {
    s.write_all("HTTP/1.1 400 Bad Request
Content-Type: text/plain
Connection: close

Bad request
".as_bytes())
}

fn get_root(mut s: TcpStream) -> std::io::Result<()> {
    let contents = include_str!("index.html");
    s.write_all(("HTTP/1.1 200 OK
Content-Type: text/html
Connection: close

".to_string() + contents).as_bytes())
}

fn get_vga_picture(mut s: TcpStream, vga: &Arc<Mutex<Vga>>) -> std::io::Result<()> {
    s.write_all("HTTP/1.1 200 Ok\nContent-Type: image/png\n\n".as_bytes())?;
    match vga.lock().unwrap().create_image(s) {
        Ok(()) => {
            Ok(())
        }
        _ => {
            Ok(())
        }
    }
}

fn not_found(mut s: TcpStream) -> std::io::Result<()> {
    s.write_all("HTTP/1.1 404 Not found
Content-Type: text/plain
Connection: close

Not found
".as_bytes())
}

fn handle_connection(mut s: TcpStream, vga: &Arc<Mutex<Vga>>) -> std::io::Result<()> {
    let mut poll = Poll::new().unwrap();
    let mut events = Events::with_capacity(128);
    poll.registry().register(&mut s, Token(0), Interest::READABLE)?;
    poll.poll(&mut events, None).unwrap();
    let reader = BufReader::new(&s);
    let re = Regex::new(r"^GET ([^ ?]+)(?:\?\S*)? HTTP/1.1$").unwrap();
    let result = match reader.lines().next() {
        Some(Ok(line)) => {
            match re.captures(&line) {
                None => bad_request(s),
                Some(cap) => {
                    match &cap[1] {
                        "/" => get_root(s),
                        "/vga.png" => get_vga_picture(s, vga),
                        _ => not_found(s)
                    }
                }
            }
        }
        e => {
            println!("{:?}", e);
            bad_request(s)
        }
    };
    match result {
        Err(e) => eprintln!("{:?}", e),
        _ => ()
    }
    Ok(())
}

fn serve(port: u16, rx: mpsc::Receiver<()>, vga: Arc<Mutex<Vga>>) -> std::io::Result<()> {
    let address = SocketAddr::new(IpAddr::V4(Ipv4Addr::new(127, 0, 0, 1)), port);
    let mut listener = TcpListener::bind(address)?;
    let mut poll = Poll::new()?;
    let mut events = Events::with_capacity(128);
    poll.registry().register(&mut listener, Token(0), Interest::READABLE)?;
    println!("Server started at http://localhost:{}", port);
    loop {
        poll.poll(&mut events, Some(Duration::from_millis(100)))?;
        match listener.accept() {
            Ok((s,_)) => {
                handle_connection(s, &vga)?;
            }
            Err(ref e) if e.kind() == std::io::ErrorKind::WouldBlock => {}
            Err(e) => return Err(e)
        }
        match rx.try_recv() {
            Ok(()) => break,
            Err(mpsc::TryRecvError::Disconnected) => {
                eprintln!("Sender disconnected");
                break;
            }
            Err(mpsc::TryRecvError::Empty) => {}
        }
    }
    Ok(())
}
