from prefect import flow


@flow
def hello_deployments():
    print("Hello, world!")


if __name__ == "__main__":
    hello_deployments()
