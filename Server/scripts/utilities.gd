class_name Utils
extends Node


func write_log(log_widget: TextEdit, log: String):
	log_widget.set_caret_line(log_widget.get_line_count())
	log_widget.insert_text_at_caret('%s\n' % log)


func kick_client(id: int, clients: Array, log_widget: TextEdit, rem_client_callback: Callable):
	if id in clients:
		write_log(log_widget, 'Kicking client %s' % id)
		multiplayer.multiplayer_peer.disconnect_peer(id)
		rem_client_callback.call(id)
	else:
		write_log(log_widget, 'Couldn\'t find client %s' % id)
