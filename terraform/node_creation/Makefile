clean:
	@echo "Cleaning up..."
	rm -rf ./.terraform *.tfstate *.backup

init: clean
	terraform init

plan: init format get validate
	terraform plan -out=terraform.tfplan
	
apply: plan
	terraform apply -var "compartment_name=$(NameSpace)" -lock=false -auto-approve

