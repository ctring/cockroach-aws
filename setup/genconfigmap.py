import copy
import yaml

stanzas_file = open('configmap-stanzas.yaml')
stanzas = yaml.full_load(stanzas_file)

configmap_file = open('configmap.yaml')
configmap = yaml.full_load(configmap_file)

corefile = configmap['data']['Corefile']

class block(str): pass

def block_representer(dumper, data):
    return dumper.represent_scalar(u'tag:yaml.org,2002:str', data, style='|')

yaml.add_representer(block, block_representer)

for r, stanza in stanzas.items():
    new_stanzas = copy.deepcopy(stanzas)
    new_stanzas.pop(r)
    forward = ''.join(new_stanzas.values())
    configmap['data']['Corefile'] = block(f'{corefile}\n{forward}')
    with open(f"configmap-{r}.yaml", "w") as f:
        yaml.dump(configmap, f,  width=10000)

configmap_file.close()
stanzas_file.close()
