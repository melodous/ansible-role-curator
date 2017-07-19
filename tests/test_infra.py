def test_curator_server_running_and_enabled(Command, Service):
    # Check that docker service is running and enabled
    docker_service = Service("docker")
    assert docker_service.is_running
    assert docker_service.is_enabled
    # Check that curator service is running and enabled
    curator_service = Service("curator")
    assert curator_service.is_running
    assert curator_service.is_enabled


def test_curator_start_stop(Command, Service):
    # Check init scripts are working
    Command.run_expect([0], "systemctl stop curator")
    curator_service = Service("curator")
    assert not curator_service.is_running
    Command.run_expect([0], "systemctl start curator")
    assert curator_service.is_running
    Command.run_expect([0], "systemctl restart curator")
    assert curator_service.is_running
