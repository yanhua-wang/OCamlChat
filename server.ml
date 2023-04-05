open Unix
open Thread

let port = 8000

let handle_client sock =
  (* Open input and output channels for the socket *)
  let in_chan = in_channel_of_descr sock in
  let out_chan = out_channel_of_descr sock in
  (* Loop forever, reading input from the client and echoing it back *)
  while true do
    let line = input_line in_chan in
    Printf.printf "Received: %s\n%!" line;
    output_string out_chan (line ^ "\n");
    flush out_chan
  done

let () =
  (* Create a socket and bind it to the specified port *)
  let sock = socket PF_INET SOCK_STREAM 0 in
  bind sock (ADDR_INET (inet_addr_any, port));
  (* Listen for incoming connections *)
  listen sock 5;
  Printf.printf "Server listening on port %d\n%!" port;
  (* Loop forever, accepting incoming connections and spawning new threads to handle them *)
  while true do
    let client_sock, client_addr = accept sock in
    Printf.printf "Accepted connection from %s\n%!"
      (string_of_inet_addr (fst client_addr));
    let _ = Thread.create handle_client client_sock in
    ()
  done