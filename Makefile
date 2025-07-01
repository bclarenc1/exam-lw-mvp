gcloud-set-project:
	gcloud config set project $(GCP_PROJECT)

# Build container and image
docker_build_local:
	docker build \
	--tag=$(DOCKER_IMAGE):dev .

docker_run_local:
	docker run -it \
		-e PORT=8000 -p $(DOCKER_LOCAL_PORT):8000 \
		--env-file .env \
		$(DOCKER_IMAGE):local \
		bash

DOCKER_IMAGE_PATH := $(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(ARTIFACT_REPO)/$(DOCKER_IMAGE)

docker_build_prod:
	docker build \
	--platform linux/amd64 \
	-t $(DOCKER_IMAGE_PATH):prod .

docker_run_prod:
	docker run \
		--platform linux/amd64 \
		-e PORT=8000 -p $(DOCKER_LOCAL_PORT):8000 \
		--env-file .env \
		$(DOCKER_IMAGE_PATH):prod

# Push and deploy to cloud
docker_allow:
	gcloud auth configure-docker $(GCP_REGION)-docker.pkg.dev

docker_create_repo:
	gcloud artifacts repositories create $(ARTIFACT_REPO) \
		--repository-format=docker \
		--location=$(GCP_REGION) \
		--description="Repository for storing docker images"

docker_push_image:
	docker push $(DOCKER_IMAGE_PATH):prod

docker_deploy_image:
	gcloud run deploy \
		--image $(DOCKER_IMAGE_PATH):prod \
		--memory $(GAR_MEMORY) \
		--region $(GCP_REGION) \
		--env-vars-file .env.yaml
