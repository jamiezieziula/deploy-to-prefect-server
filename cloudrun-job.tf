resource "google_cloud_run_v2_job" "deploy_prefect_flows" {
  name         = "deploy-prefect-flows"
  location     = "us-east1"
  launch_stage = "GA"

  template {
    template {
      containers {
        args = [
          "prefect --no-prompt deploy --all --prefect-file prefect-flows/prefect.yaml"
        ]
        command = ["/bin/sh", "-c"]
        image   = "us-docker.pkg.dev/gcp-project-id/prefect-flows:latest"
        name    = "deploy-prefect-flows"

        resources {
          limits = {
            cpu    = "1"
            memory = "1Gi"
          }
        }
        env {
          name  = "PREFECT_API_URL"
          value = "https://prefect-server.your-domain.com/api"
        }
      }

      execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
      max_retries           = 1
      service_account       = "cloudrun-deploy-prefect-flows@gcp-project-id.iam.gserviceaccount.com"
      vpc_access {
        connector = "projects/gcp-project-id/locations/us-east1/connectors/cloudrun"
        egress    = "ALL_TRAFFIC"
      }
    }
  }
}