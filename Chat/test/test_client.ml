open OUnit2;;
open Unix;;

let test_client_connection _ =
  (* Open a socket and connect to the server *)
  let sock = socket PF_INET SOCK_STREAM 0 in
  connect sock (ADDR_INET (inet_addr_loopback, 8000));
  (* Read and verify the server's response *)
  let response = input_line (in_channel_of_descr sock) in
  assert_equal "Hello, world!" response;
  (* Close the socket *)
  close sock

let suite = "client_suite" >::: [
    "test_client_connection" >:: test_client_connection;
]

let () = run_test_tt_main suite