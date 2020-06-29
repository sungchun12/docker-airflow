from airflow import DAG
from datetime import datetime, timedelta
from airflow.contrib.operators.kubernetes_pod_operator import KubernetesPodOperator
from airflow.contrib.kubernetes.secret import Secret
import os

"""Runs a single dbt command with the KubernetesPodOperator on local setup
   where airflow runs outside the kubernetes cluster.
"""

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2001, 1, 1),
    "email": ["airflow@example.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 0,
}

DBT_IMG = os.environ.get("DOCKER_DBT_IMG")

# Using environment variable directly
# Insecure for production, but this works for local macbook development
service_account = os.environ.get("SERVICE_ACCOUNT")

with DAG("dbt_kube_dag_simple", default_args=default_args, schedule_interval=None) as dag:
    # For local environment
    # it is important to set config_file to point to k3d
    # and set in_cluster=False
    dbt_debug = KubernetesPodOperator(
        task_id = "dbt-debug",
        name = "dbt-debug",
        namespace="default",
        image=DBT_IMG,
        cmds=["/bin/bash", "-cx", "/entrypoint.sh && ls -ltr && dbt debug"],
        config_file="/usr/local/airflow/.kube/config",
        env_vars={'SERVICE_ACCOUNT': service_account},
        image_pull_policy="Always",
        in_cluster=False,
        is_delete_operator_pod=True,
        get_logs=True,
    )
    dbt_debug