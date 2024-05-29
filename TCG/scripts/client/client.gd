class_name Client
extends Node

const SERVER_IP: String = '192.168.50.224'
const SERVER_PORT: int = 65432
const HEADER_SIZE: int = 64
const FORMAT: String = 'utf-8'
const SERVER_COMMANDS: Dictionary = {
	'disconnect': '!DISCON',
	'global_msg': '!GLOBAL',
	'object': '!OBJECT',
	'login': '!LOGIN',
	'authenticate': '!AUTH',
	'string': '!STR',
}
var client: StreamPeer
