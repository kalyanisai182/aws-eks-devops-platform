.PHONY: bootstrap test run eks-init eks-apply eks-destroy k8s-init k8s-apply k8s-configure k8s-deploy k8s-destroy

bootstrap:
	cd terraform/bootstrap && terraform init && terraform apply

test:
	cd app && pip install -q -r requirements-dev.txt && pytest -v

run:
	cd app && python app.py

# ---- Path A: managed EKS ----
eks-init:
	cd terraform/eks && terraform init -backend-config=../backend.hcl -backend-config="key=eks/terraform.tfstate"
eks-apply:
	cd terraform/eks && terraform apply
eks-destroy:
	cd terraform/eks && terraform destroy

# ---- Path B: Terraform (EC2) + Ansible (Docker, Kubernetes) ----
k8s-init:
	cd terraform/ec2-k8s && terraform init -backend-config=../backend.hcl -backend-config="key=ec2-k8s/terraform.tfstate"
k8s-apply:
	cd terraform/ec2-k8s && terraform apply
k8s-configure:
	cd ansible && ansible-playbook playbooks/site.yml
k8s-deploy:
	cd ansible && ansible-playbook playbooks/04-deploy-app.yml -e app_image=$(IMAGE)
k8s-destroy:
	cd terraform/ec2-k8s && terraform destroy
