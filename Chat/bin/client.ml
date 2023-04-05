open Unix

let () =
  (* Create a new TCP socket *)
  let sock = socket PF_INET SOCK_STREAM 0 in

  (* Set the server address *)
  let server_address = ADDR_INET (inet_addr_of_string "127.0.0.1", 8000) in

  (* Connect to the server *)
  connect sock server_address;

  (* Read lines from standard input and send them to the server *)
  while true do
    (* read a line from standard input *)
    let line = input_line (Unix.in_channel_of_descr Unix.stdin) in

    (* Send the line to the server *)
    let output_buffer = Bytes.of_string line in
    let len = Bytes.length output_buffer in
    ignore (send sock output_buffer 0 len []);

    (* Receive the response from the server *)
    let input_buffer = Bytes.create 1024 in
    let len = recv sock input_buffer 0 1024 [] in
    let response = Bytes.sub input_buffer 0 len |> Bytes.to_string in
    print_endline response;
  done