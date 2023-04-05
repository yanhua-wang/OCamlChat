open OUnit2;;
open Unix;;

let test_server_connection _ =
  (* Open a socket and connect to the server *)
  let sock = socket PF_INET SOCK_STREAM 0 in
  connect sock (ADDR_INET (inet_addr_loopback, 8000));
  (* Verify that the server accepted the connection *)
  let client_sock, _ = accept (socket PF_INET SOCK_STREAM 0) in
  assert_equal sock client_sock;
  (* Close the sockets *)
  close sock;
  close client_sock

let suite = "server_suite" >::: [
    "test_server_connection" >:: test_server_connection;
]


let () = run_test_tt_main suite