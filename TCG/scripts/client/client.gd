class_name Client
extends Node

const SERVER_IP: String = '192.168.50.224'
const SERVER_PORT: int = 65432
const HEADER_SIZE: int = 64
const FORMAT: String = 'utf-8'
const SERVER_REQUESTS: Dictionary = {
	'disconnect': '!DISCON',
	'global_msg': '!GLOBAL',
	'object': '!OBJECT',
	'login': '!LOGIN',
	'authenticate': '!AUTH',
	'string': '!STR',
}
var client: StreamPeer
var connected: bool = false


func connect_to_server(cli: StreamPeer) -> String:
	if not cli:
		return 'Missing TCP client!'
	
	client = cli
	var error = client.connect_to_host(G.client.SERVER_IP, G.client.SERVER_PORT)
	
	if error == OK:
		G.client.connected = true
		return 'Connected to the server!'
	else:
		return 'Failed to connect to server!'

func send_data(payload: String) -> String:
	assert(connected, 'Error: Not connected to server!')
	assert('CMD' in payload, 'Error: %s' % payload)
	
	var packet = payload.to_utf8_buffer()
	var sent = client.put_data(packet)
	
	if sent == OK:
		return 'Data sent successfully'
	else:
		return 'Failed to send data, error code: %s' % sent

func poll_server():
	if not connected:
		return 'Not connected to server!'
	
	var bytes_data = client.get_available_bytes()
	
	if not bytes_data > 0:
		return
	
	print(bytes_data)
	var received_data = client.get_data(bytes_data)
	print(received_data)
	var text_data: String = received_data.get_string_from_utf8()
	print(text_data)

func prepare_payload(payload, request_type: String) -> String:
	if request_type not in SERVER_REQUESTS:
		return 'Error: Invalid request type "%s"' % request_type
	
	var request: String = SERVER_REQUESTS[request_type]
	var invalid_payload_err: String = 'Invalid payload format!'
	
	if request == SERVER_REQUESTS['string']:
		return payload
	elif request == SERVER_REQUESTS['login']:
		if 'username' not in payload and 'password' not in payload:
			return 'Error: %s' % invalid_payload_err
		payload['CMD'] = SERVER_REQUESTS['login']
		return JSON.stringify(payload)
	else:
		return invalid_payload_err
