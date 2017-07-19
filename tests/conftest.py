import pytest

# Load ansible facts
@pytest.fixture(scope="module")
def AnsibleFacts(Ansible):
    return Ansible("setup")['ansible_facts']

# Load role defaults
@pytest.fixture(scope="module")
def AnsibleDefaults(Ansible):
    return Ansible("include_vars","./defaults/main.yml")["ansible_facts"]

# Load role vars
@pytest.fixture(scope="module")
def AnsibleVars(Ansible):
    return Ansible("include_vars","./vars/main.yml")["ansible_facts"]

# Load vars depending on the os family
@pytest.fixture(scope="module")
def AnsibleVarsFamily(Ansible, AnsibleFacts):
    ansible_os_family = AnsibleFacts['ansible_os_family']
    return Ansible("include_vars","./vars/%s.yml" % ansible_os_family)["ansible_facts"]

# Load role vars depending on the os family and version
@pytest.fixture(scope="module")
def AnsibleVarsVer(Ansible, AnsibleFacts):
    ansible_os_family = AnsibleFacts['ansible_os_family']
    ansible_distribution_major_version = AnsibleFacts['ansible_distribution_major_version']
    return Ansible("include_vars","./vars/%s%s.yml" % (ansible_os_family,ansible_distribution_major_version))["ansible_facts"]

# Load role vars in the same way as ansible does.
# Order: role defaults, facts, vars.
@pytest.fixture(scope="module")
def AnsibleAllVars(Ansible, AnsibleFacts, AnsibleVars, AnsibleDefaults):
    result= AnsibleDefaults
    result.update(AnsibleFacts)
    result.update(AnsibleVars)
    return result

# Load role vars in the same way as ansible does, using AnsibleVarsVer.
# Order: role defaults, facts, vars.
@pytest.fixture(scope="module")
def AnsibleAllVarsVer(Ansible, AnsibleFacts, AnsibleVarsVer, AnsibleDefaults):
    result= AnsibleDefaults
    result.update(AnsibleFacts)
    result.update(AnsibleVarsVer)
    return result
