open Unix

let server_addr = Unix.inet_addr_of_string "127.0.0.1"
let server_port = 8000

let () =
  (* Create a socket and connect to the server *)
  let sock = socket PF_INET SOCK_STREAM 0 in
  connect sock (ADDR_INET (server_addr, server_port));
  (* Open input and output channels for the socket *)
  let in_chan = in_channel_of_descr sock in
  let out_chan = out_channel_of_descr sock in
  (* Loop forever, reading input from the user and sending it to the server *)
  while true do
    let line = input_line stdin in
    output_string out_chan (line ^ "\n");
    flush out_chan;
    (* Wait for a response from the server and print it to the console *)
    let response = input_line in_chan in
    Printf.printf "Server response: %s\n%!" response
  done