connection:
	@echo "Connecting to Control Plane..."
	@$$(terraform output -json|jq ".control_plane_connection_command.value"| sed 's/\\n//g' | sed 's/"//g')

conn: connection

up:
	terraform apply

down:
	terraform destroy