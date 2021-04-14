clean:
	@echo "Cleaning up..."
	@cd tf_environment && \
	rm -rf ./.terraform *.tfstate *.backup

get:
	@echo "Updating modules"
	@cd tf_environment && \
	terraform get -update

init: clean
	@cd tf_environment && \
	terraform init

validate: init
	@cd tf_environment && \
	terraform validate

plan: init format get validate
	@cd tf_environment && \
	terraform plan -out=terraform.tfplan

format:
	@cd tf_environment && \
	terraform fmt
	
apply: plan
	@cd tf_environment && \
	terraform apply -var "file_system_name=$(NameSpace)" -var "export_path=/$(NameSpace)" -var "subnet_ocid=$(subOcid)" -lock=false -auto-approve

# destroy: init
# 	@cd tf_environment && \
# 	terraform destroy -var "file_system_name=$(NameSpace)" -var "export_path=/$(NameSpace)" -var "subnet_ocid=$(subOcid)" -lock=false -auto-approve
