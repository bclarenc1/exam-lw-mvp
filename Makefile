build_container_local:
	docker build --tag=exam-lw-mvp-image:dev .

run_container_local:
	docker run -it -e PORT=8000 -p 8000:8000 exam-lw-mvp-image:dev

build_for_production:
	docker build -t europe-west1-docker.pkg.dev/exam-lw-mvp/exam-lw-mvp-artifact-repo/exam-lw-mvp-image:prod .

build_for_production_m1:
	docker build --platform linux/amd64 -t europe-west1-docker.pkg.dev/exam-lw-mvp/exam-lw-mvp-artifact-repo/exam-lw-mvp-image:prod .

push_image_production:
	docker push europe-west1-docker.pkg.dev/exam-lw-mvp/exam-lw-mvp-artifact-repo/exam-lw-mvp-image:prod

deploy_to_cloud_run:
	gcloud run deploy --image europe-west1-docker.pkg.dev/exam-lw-mvp/exam-lw-mvp-artifact-repo/exam-lw-mvp-image:prod --memory 512Mi --region europe-west1
