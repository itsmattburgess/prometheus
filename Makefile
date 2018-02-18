
.PHONY: build

build:
	@cd terraform && terraform apply
	@cd terraform && terraform output ansible_inventory > $(PWD)/ansible/inventory
	@ansible-playbook -i $(PWD)/ansible/inventory $(PWD)/ansible/playbook.yml
	@echo "Build complete."

destroy:
	@cd terraform && terraform destroy
