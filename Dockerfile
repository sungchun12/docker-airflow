# we have to use the officially working release as building on your own will result in errors
# this is the nature of ad hoc open souce tools :/
FROM puckel/docker-airflow:1.10.9


# install custom python requirements
COPY requirements.txt /usr/local/airflow/requirements.txt

RUN pip install -r /usr/local/airflow/requirements.txt